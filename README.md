# Aapt2 package build workflow

[![build workflow](../../actions/workflows/release.yml/badge.svg)](../../actions/workflows/release.yml)

This repository contains a workflow to build the aapt2 binaries for Android.

Currently, the submodules are pinned to platform-tools 35.0.2 of AOSP source code. `src/base` example:
https://android.googlesource.com/platform/frameworks/base/+/refs/tags/platform-tools-35.0.2

# Build

## Clone with submodules
```bash
git clone --recurse-submodules --shallow-submodules --depth 1 https://github.com/ReVanced/aapt2
```

## Protoc dependency

`protoc` needs to be installed, the current required version is 21.12. Install it with:
```bash
wget https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protoc-21.12-linux-x86_64.zip
sudo unzip -p protoc-*.zip bin/protoc -d /usr/local/bin/
```

The required version can be identified with :
```bash
grep PROTOC_VERSION submodules/protobuf/protobuf_version.bzl
```

## Apply patch
```bash
./patch.sh
```

## Build the binary

Supported arch are 'x86_64', 'x86', 'arm64-v8a' & 'armeabi-v7a'
```bash
ANDROID_NDK="$HOME/Android/Sdk/ndk/27.3.13750724/" ./build.sh arm64-v8a  # Build output in build/bin/aapt-*
```

# Credits

This repository is made with the help of:
- [lzhiyong](https://github.com/lzhiyong/android-sdk-tools)
- [iBotPeaches](https://github.com/aosp-mirror/platform_frameworks_base/compare/main...iBotPeaches:platform_frameworks_base:apktool_14.0.0) for [apktool_ibotpeaches.patch](patches/apktool_ibotpeaches.patch])
