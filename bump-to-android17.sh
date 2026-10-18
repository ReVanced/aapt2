#!/bin/bash
# Arahkan semua submodule ReVanced/aapt2 ke tag AOSP Android 17 (API 37).
# Jalankan di root repo ReVanced/aapt2, SEBELUM ./patch.sh.
#
# Pemakaian:
#   git clone --recurse-submodules --shallow-submodules --depth 1 https://github.com/ReVanced/aapt2
#   cd aapt2
#   bash bump-to-android17.sh [tag]      # default: android-17.0.0_r1
#
# BELUM DIUJI. Kemungkinan besar patch.sh dan cmake/*.cmake perlu diperbaiki manual.

set -uo pipefail

TAG="${1:-android-17.0.0_r1}"
MISSING=()

git submodule update --init --depth 1

for dir in submodules/*/; do
  name=$(basename "$dir")
  if git -C "$dir" fetch --depth 1 origin "refs/tags/$TAG:refs/tags/$TAG" 2>/dev/null; then
    git -C "$dir" checkout -q "tags/$TAG"
    echo "OK    $name -> $TAG"
  else
    echo "MISS  $name (tag $TAG tidak ditemukan, tetap di commit lama)"
    MISSING+=("$name")
  fi
done

# Hanya mengubah teks versi yang dicetak oleh `aapt2 version`.
sed -i 's/PLATFORM_TOOLS_VERSION ".*"/PLATFORM_TOOLS_VERSION "37.0.0"/' misc/platform_tools_version.h

echo
echo "Versi protoc yang dibutuhkan protobuf submodule (workflow memakai 21.12):"
grep PROTOC_VERSION submodules/protobuf/protobuf_version.bzl || echo "  (tidak ditemukan)"

echo
if [ ${#MISSING[@]} -gt 0 ]; then
  echo "Submodule tanpa tag $TAG: ${MISSING[*]}"
  echo "Cari tag/branch yang cocok untuknya di AOSP, atau biarkan di versi lama."
fi
echo "Langkah berikut: ./patch.sh  lalu  ANDROID_NDK=... ./build.sh arm64-v8a"
