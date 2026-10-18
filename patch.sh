#!/bin/bash
# Jalankan di root repo, SETELAH submodule di-checkout ke tag AOSP Android 17.
set -u

mkdir -p "submodules/incremental_delivery/sysprop/include/"
cp "misc/IncrementalProperties.sysprop.h" "submodules/incremental_delivery/sysprop/include/"
cp "misc/IncrementalProperties.sysprop.cpp" "submodules/incremental_delivery/sysprop/"

mkdir -p "submodules/soong/cc/libbuildversion/include"
cp "misc/platform_tools_version.h" "submodules/soong/cc/libbuildversion/include"

# As our sources are in submodules and not in frameworks/base/tools/aapt2 we need to change the inclusions
configPattern="s#frameworks/base/tools/aapt2/Configuration.proto#Configuration.proto#g"
ressourcesPattern="s#frameworks/base/tools/aapt2/Resources.proto#Resources.proto#g"

sed -i "$configPattern" "submodules/base/tools/aapt2/Resources.proto"
sed -i "$configPattern" "submodules/base/tools/aapt2/ResourcesInternal.proto"

sed -i "$ressourcesPattern" "submodules/base/tools/aapt2/ApkInfo.proto"
sed -i "$ressourcesPattern" "submodules/base/tools/aapt2/ResourcesInternal.proto"

# Menerapkan:
#  - modifikasi IBotPeaches untuk apktool   (patches/apktool_ibotpeaches.patch)
#  - fix BusError 32-bit di armv8           (patches/32bsystem_on_armv8.patch)
#  - fix CMake protobuf                     (menggantikan patches/protobuf.patch)
# `git apply` dulu gagal total di Android 17 (patch all-or-nothing), jadi memakai
# skrip yang mencocokkan hunk berdasarkan isi kode, bukan nomor baris.
python3 patches/apply_patch.py || exit 1

# Header flag aconfig (android_content_res.h, dll) tidak ada di build CMake, dibuat stub-nya.
python3 misc/gen_aconfig_stub.py || exit 1

mkdir -p "submodules/boringssl/src/third_party"
ln -sfn "$(pwd)/submodules/googletest" "submodules/boringssl/src/third_party/googletest"
