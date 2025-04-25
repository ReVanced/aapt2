# Aapt2 package build workflow

[![build workflow](https://github.com/revanced/aapt2/actions/workflows/build.yml/badge.svg)](https://github.com/revanced/aapt2/actions/workflows/build.yml)

This repository contains a workflow to build the aapt2 binaries for Android.

# Build aapt2
## Fetch submodules
```bash
git submodule update --init --recursive --depth 1
```

## Apply patch
```bash
bash ./patch.sh
```

## Build protoc
```bash
mkdir -p src/protobuf/build
pushd src/protobuf/build
cmake -GNinja -Dprotobuf_BUILD_TESTS=OFF ..
ninja -j$(nproc --all)
popd
```

## Build the binary
Supported arch are 'x86_64', 'x86', 'arm64-v8a' & 'armeabi-v7a'
```bash
ANDROID_NDK="$HOME/Android/Sdk/ndk/" PROTOC_PATH="$PWD/src/protobuf/build/protoc" bash ./build.sh arm64-v8a  # output in build/$arch/bin/aapt-*
```

# Resources
This repository is based on the works of:
- [lzhiyong](https://github.com/lzhiyong/android-sdk-tools)
- [iBotPeaches](https://github.com/aosp-mirror/platform_frameworks_base/compare/main...iBotPeaches:platform_frameworks_base:apktool_14.0.0) for [apktool_ibotpeaches.patch](patches/apktool_ibotpeaches.patch])
