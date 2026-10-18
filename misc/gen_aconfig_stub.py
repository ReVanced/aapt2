#!/usr/bin/env python3
"""Buat header stub aconfig (mis. android_content_res.h) untuk build aapt2 di luar AOSP.

Di AOSP header ini dihasilkan oleh `aconfig` dari file *.aconfig. Build CMake tidak punya
aconfig, jadi header dibuat sendiri:
  1. cari semua file *.aconfig di submodules/base  -> paket + nama flag
  2. cari #include "<paket_dengan_underscore>.h" di sumber androidfw & aapt2
  3. untuk tiap header yang dipakai, tulis fungsi inline per flag: di namespace paketnya
     (a::b::flag()) dan gaya global (a_b_flag()), keduanya dipakai kode AOSP

Semua flag diset NONAKTIF (false). Untuk mengaktifkan flag tertentu, taruh namanya
(satu per baris, tanpa paket) di misc/aconfig_enabled.txt lalu jalankan ulang skrip.

Taruh di: misc/gen_aconfig_stub.py   |  Output: misc/generated_flags/
Dijalankan dari patch.sh.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BASE = ROOT / "submodules/base"
SCAN_DIRS = [BASE / "libs/androidfw", BASE / "tools/aapt2"]
OUT = ROOT / "misc/generated_flags"
ENABLED_FILE = ROOT / "misc/aconfig_enabled.txt"


def parse_aconfig(path):
    text = path.read_text(encoding="utf-8", errors="replace")
    text = re.sub(r"#[^\n]*", "", text)  # komentar
    pkg = re.search(r'\bpackage\s*:\s*"([^"]+)"', text)
    if not pkg:
        return None, []
    names = []
    for block in re.finditer(r"\bflag\s*\{(.*?)\}", text, re.S):
        m = re.search(r'\bname\s*:\s*"([^"]+)"', block.group(1))
        if m:
            names.append(m.group(1))
    return pkg.group(1), names


def main():
    if not BASE.is_dir():
        print("submodules/base tidak ada, lewati")
        return 0

    packages = {}  # header -> (package, [flags])
    for f in BASE.rglob("*.aconfig"):
        pkg, names = parse_aconfig(f)
        if pkg:
            hdr = pkg.replace(".", "_") + ".h"
            entry = packages.setdefault(hdr, (pkg, []))
            entry[1].extend(n for n in names if n not in entry[1])
    print(f"{len(packages)} paket aconfig ditemukan")

    wanted = set()
    inc = re.compile(r'#\s*include\s*[<"]([A-Za-z0-9_]+\.h)[>"]')
    for d in SCAN_DIRS:
        for f in d.rglob("*"):
            if f.suffix in (".cpp", ".cc", ".h") and f.is_file():
                for m in inc.finditer(f.read_text(encoding="utf-8", errors="replace")):
                    if m.group(1) in packages:
                        wanted.add(m.group(1))

    enabled = set()
    if ENABLED_FILE.is_file():
        enabled = {l.strip() for l in ENABLED_FILE.read_text().splitlines()
                   if l.strip() and not l.startswith("#")}

    OUT.mkdir(parents=True, exist_ok=True)
    for hdr in sorted(wanted):
        pkg, flags = packages[hdr]
        ns = "::".join(pkg.split("."))
        lines = [
            "// Dibuat oleh misc/gen_aconfig_stub.py (stub, bukan hasil aconfig asli).",
            "#pragma once",
            "",
            "#ifdef __cplusplus",
            f"namespace {ns} {{",
            "",
        ]
        for n in flags:
            val = "true" if n in enabled else "false"
            lines.append(f"inline constexpr bool {n}() {{ return {val}; }}")
        lines += ["", "inline void reset_flags() {}", "", f"}}  // namespace {ns}", ""]
        # gaya C/global yang dipakai androidfw: android_content_res_<flag>()
        prefix = pkg.replace(".", "_")
        for n in flags:
            val = "true" if n in enabled else "false"
            lines.append(f"inline bool {prefix}_{n}() {{ return {val}; }}")
        lines += ["#endif", ""]
        (OUT / hdr).write_text("\n".join(lines))
        print(f"OK    {hdr}: {len(flags)} flag, namespace {ns}")

    # header yang di-include tapi paketnya tidak ketemu: beri peringatan saja
    print(f"{len(wanted)} header stub dibuat di {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
