#!/usr/bin/env python3
"""Terapkan patch ke submodules AOSP (Android 17) tanpa bergantung pada `git apply`.

Kenapa dibuat:
  `git apply` bersifat all-or-nothing per patch. Di Android 17 beberapa hunk dari
  apktool_ibotpeaches.patch tidak cocok lagi (ConfigDescription.cpp, Link.cpp, Link.h),
  jadi SELURUH patch gagal dan tidak ada yang terpasang.

Cara kerja:
  1. Setiap hunk dicari di file target berdasarkan ISI (bukan nomor baris), dengan
     toleransi spasi dan fuzz konteks sampai 3 baris.
  2. Hunk yang sudah terpasang dilewati (aman dijalankan berulang).
  3. Untuk hunk yang kodenya berubah di Android 17, ada fallback semantik (regex).
  4. Perbaikan CMake protobuf (menggantikan patches/protobuf.patch) dilakukan di sini.

Pemakaian (dari root repo):  python3 patches/apply_patch.py
Taruh file ini di:           patches/apply_patch.py
Exit code 1 bila ada hunk penting (aapt2 / androidfw) yang gagal.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PATCHES = ["patches/apktool_ibotpeaches.patch", "patches/32bsystem_on_armv8.patch"]

# Hunk di path ini tidak ikut dikompilasi (aapt lama), gagal = cukup peringatan.
NON_CRITICAL = ("submodules/base/tools/aapt/",)


# ---------------------------------------------------------------- parsing patch
def parse_patch(text):
    files, cur, hunk = [], None, None
    for line in text.splitlines():
        if line.startswith("diff --git "):
            m = re.match(r"diff --git a/(\S+) b/(\S+)", line)
            cur = (m.group(2), [])
            files.append(cur)
            hunk = None
        elif line.startswith("@@") and cur is not None:
            m = re.match(r"@@ -(\d+)(?:,\d+)? \+\d+(?:,\d+)? @@", line)
            hunk = {"start": int(m.group(1)), "lines": []}
            cur[1].append(hunk)
        elif hunk is not None and line[:1] in (" ", "-", "+"):
            hunk["lines"].append((line[0], line[1:]))
        elif hunk is not None and line == "":
            hunk["lines"].append((" ", ""))
    return files


def norm(s):
    return re.sub(r"\s+", " ", s.strip())


def find_block(flines, block, hint, loose):
    n = len(block)
    if n == 0 or n > len(flines):
        return None
    key = [norm(x) if loose else x for x in block]
    cands = []
    for i in range(len(flines) - n + 1):
        for j in range(n):
            f = flines[i + j]
            if (norm(f) if loose else f) != key[j]:
                break
        else:
            cands.append(i)
    return min(cands, key=lambda i: abs(i - hint)) if cands else None


# ------------------------------------------------------------ fallback semantik
APKTOOL_EXT_BLOCK = """\
  // Populate no compress extensions specified in the extensions file.
  if (options_.extensions_to_not_compress_path) {
    std::ifstream extensionsFile(options_.extensions_to_not_compress_path.value());

    if (extensionsFile.fail()) {
      context.GetDiagnostics()->Error(
        android::DiagMessage() << "could not open extensions file "
          << options_.extensions_to_not_compress_path.value()
          << " for reading");
      return 1;
    }

    for (std::string line; getline(extensionsFile, line);) {
      options_.extensions_to_not_compress.insert(line);
    }
  }

"""


def fb_config_description(text):
    fn = text.rfind("ConfigDescription::ApplyVersionForCompatibility")
    if fn < 0:
        return None
    m = re.compile(r"^([ \t]*)config->sdkVersion\s*=\s*min_sdk;", re.M).search(text, fn)
    if not m:
        return None
    i = m.group(1)
    rep = (f"{i}// Apktool: We are skipping this entirely in apktool, because the application has\n"
           f"{i}// already been built once. Doing this changes the application with implicit\n"
           f"{i}// version information, which may not have been in the original.\n"
           f"{i}//config->sdkVersion = min_sdk;")
    return text[:m.start()] + rep + text[m.end():]


def fb_link_cpp(text):
    if "options_.extensions_to_not_compress_path" in text:
        return text
    m = (re.search(r"^[ \t]*//\s*Turn off auto versioning for static-libs\.", text, re.M)
         or re.search(r"^[ \t]*if \(context\.GetPackageType\(\) == PackageType::kStaticLib\) \{\s*\n"
                      r"\s*options_\.no_auto_version = true;", text, re.M))
    if not m:
        return None
    text = text[:m.start()] + APKTOOL_EXT_BLOCK + text[m.start():]
    if "#include <fstream>" not in text:
        inc = re.search(r"^#include <", text, re.M)
        if inc:
            text = text[:inc.start()] + "#include <fstream>\n" + text[inc.start():]
    return text


def fb_link_h_field(text):
    m = re.search(r"^([ \t]*)std::unordered_set<std::string>\s+extensions_to_not_compress;[^\n]*\n",
                  text, re.M)
    if not m:
        return None
    add = f"{m.group(1)}std::optional<std::string> extensions_to_not_compress_path;\n"
    return text[:m.end()] + add + text[m.end():]


def fb_link_h_flag(text):
    m = re.search(r'^([ \t]*)AddOptionalFlagList\(\s*"-0"[^;]*;[^\n]*\n', text, re.M)
    if not m:
        return None
    i = m.group(1)
    add = (f'{i}AddOptionalFlag("-e", "File containing list of extensions not to compress.",\n'
           f"{i}    &options_.extensions_to_not_compress_path);\n")
    return text[:m.end()] + add + text[m.end():]


FALLBACKS = [
    ("libs/androidfw/ConfigDescription.cpp", "//config->sdkVersion = min_sdk;", fb_config_description),
    ("aapt2/cmd/Link.cpp", "extensions_to_not_compress_path", fb_link_cpp),
    ("aapt2/cmd/Link.h", "std::optional<std::string> extensions_to_not_compress_path;", fb_link_h_field),
    ("aapt2/cmd/Link.h", 'AddOptionalFlag("-e"', fb_link_h_flag),
]


# ------------------------------------------------------------------ apply hunks
def apply_hunk(flines, hunk, path):
    """Return (status, new_flines). status: applied | already | fuzzy | fallback | failed"""
    lines = hunk["lines"]
    old = [t for k, t in lines if k in " -"]
    new = [t for k, t in lines if k in " +"]
    added = "\n".join(t for k, t in lines if k == "+")
    hint = hunk["start"] - 1

    lead = next((i for i, (k, _) in enumerate(lines) if k != " "), len(lines))
    trail = next((i for i, (k, _) in enumerate(reversed(lines)) if k != " "), len(lines))

    # sudah terpasang? Hanya dicek dengan konteks penuh: dengan konteks dipangkas,
    # hunk yang mengubah baris serupa bisa salah dianggap sudah terpasang.
    if new != old:
        for loose in (False, True):
            if find_block(flines, new, hint, loose) is not None:
                return "already", flines
        text = "\n".join(flines)
        for suffix, marker, _ in FALLBACKS:
            if path.endswith(suffix) and marker in added and marker in text:
                return "already", flines

    for fuzz in range(4):
        a, b = min(fuzz, lead), min(fuzz, trail)
        o = old[a:len(old) - b]
        n = new[a:len(new) - b]
        if not o:
            continue
        for loose in (False, True):
            pos = find_block(flines, o, hint, loose)
            if pos is not None:
                out = flines[:pos] + n + flines[pos + len(o):]
                return ("applied" if fuzz == 0 and not loose else "fuzzy"), out

    text = "\n".join(flines)
    for suffix, marker, fn in FALLBACKS:
        if path.endswith(suffix) and marker in added:
            res = fn(text)
            if res is not None:
                return "fallback", res.split("\n")
    # Terakhir: baris lama tidak ada, tapi semua baris tambahan sudah ada di file
    # (mis. dijalankan ulang setelah penerapan fuzzy) -> anggap sudah terpasang.
    plus = [norm(t) for k, t in lines if k == "+" and t.strip()]
    if plus:
        have = {norm(x) for x in flines}
        if all(t in have for t in plus):
            return "already", flines
    return "failed", flines


def apply_patch_file(patch_path):
    failures = 0
    for path, hunks in parse_patch(patch_path.read_text(encoding="utf-8", errors="replace")):
        target = ROOT / path
        if not target.is_file():
            level = "WARN" if path.startswith(NON_CRITICAL) else "FAIL"
            print(f"{level}  {path}: file tidak ada di AOSP versi ini")
            failures += level == "FAIL"
            continue
        data = target.read_bytes().decode("utf-8", "surrogateescape")
        crlf = "\r\n" in data
        flines = data.replace("\r\n", "\n").split("\n")
        for idx, hunk in enumerate(hunks, 1):
            status, flines = apply_hunk(flines, hunk, path)
            if status == "failed":
                level = "WARN" if path.startswith(NON_CRITICAL) else "FAIL"
                failures += level == "FAIL"
                print(f"{level}  {path} hunk {idx}/{len(hunks)} (baris ~{hunk['start']}): tidak cocok")
            else:
                print(f"{status.upper():8}{path} hunk {idx}/{len(hunks)}")
        out = "\n".join(flines)
        if crlf:
            out = out.replace("\n", "\r\n")
        target.write_bytes(out.encode("utf-8", "surrogateescape"))
    return failures


# --------------------------------------------------------------------- protobuf
def fix_protobuf():
    """Pengganti patches/protobuf.patch.

    libprotobuf di-link statis; `target_link_libraries(... PRIVATE log)` membuat
    link `-static` gagal (NDK hanya punya liblog.so), jadi baris itu dikomentari.
    Struktur CMake protobuf 33.x berbeda dari 21.x sehingga patch lama tidak cocok.
    """
    base = ROOT / "submodules/protobuf"
    files = [base / "CMakeLists.txt", *sorted((base / "cmake").glob("*.cmake"))]
    pat = re.compile(r"^([ \t]*)(target_link_libraries\(\s*\S+\s+(?:PRIVATE|PUBLIC|INTERFACE)\s+log\s*\))",
                     re.M)
    changed = 0
    for f in files:
        if not f.is_file():
            continue
        text = f.read_text(encoding="utf-8", errors="replace")
        new, n = pat.subn(r"\1# static lib compiled and linked by aapt2's dedicated cmake\n\1# \2", text)
        if n:
            f.write_text(new, encoding="utf-8")
            changed += n
            print(f"APPLIED {f.relative_to(ROOT)}: {n}x 'log' link dimatikan")
    if not changed:
        print("OK      protobuf: tidak ada link 'log' yang perlu dimatikan")


def main():
    failures = 0
    for p in PATCHES:
        pf = ROOT / p
        print(f"--- {p}")
        if pf.is_file():
            failures += apply_patch_file(pf)
        else:
            print(f"FAIL  {p} tidak ditemukan")
            failures += 1
    print("--- protobuf cmake")
    fix_protobuf()
    if failures:
        print(f"\n{failures} hunk penting gagal. Kirim log ini agar bisa disesuaikan.")
        sys.exit(1)
    print("\nSemua patch selesai.")


if __name__ == "__main__":
    main()
