#!/bin/bash
set -e

# Define the targets.
API="30"
ALLOWED=("armeabi-v7a" "arm64-v8a" "x86" "x86_64")


help() {
    script_name=$(basename "$0")
    echo "Usage: $script_name <architecture>"
    echo
    echo "Required:"
    echo "  - ANDROID_NDK environment variable must be set"
    echo "  - PROTOC_PATH environment variable must be set"
    echo "  - One argument must be provided: the target architecture (armeabi-v7a, arm64-v8a, x86, x86_64)"
    echo
    echo "Example:"
    echo "  ANDROID_NDK=/path/to/ndk PROTOC_PATH=/path/to/protoc $script_name arm64-v8a"
}

# Check for ANDROID_NDK environment variable and abort if it is not set.
if [[ -z "${ANDROID_NDK}" ]]; then
    echo "Error: Please specify the Android NDK environment variable \"ANDROID_NDK\"."
    help
    exit 1
fi

# Check if PROTOC_PATH is missing or if the file doesn't exist
if [[ -z "$PROTOC_PATH" || ! -f "$PROTOC_PATH" ]]; then
    echo "Error: PROTOC_PATH is missing in env or file does not exist."
    help
    exit 1
fi

architecture="$1"

if [[ ! " ${ALLOWED[@]} " =~ " $architecture " ]]; then
    echo "Error: '$architecture' is not in the allowed archs"
    help
    exit 1
fi

NDK_TOOLCHAIN="$ANDROID_NDK/build/cmake/android.toolchain.cmake"

# Run make for the target architecture.
cmake -GNinja \
  -B "build" \
  -DANDROID_NDK="$ANDROID_NDK" \
  -DCMAKE_TOOLCHAIN_FILE="$NDK_TOOLCHAIN" \
  -DANDROID_PLATFORM="android-$API" \
  -DCMAKE_ANDROID_ARCH_ABI="$architecture" \
  -DANDROID_ABI="$architecture" \
  -DPROTOC_PATH="$PROTOC_PATH" \
  -DCMAKE_SYSTEM_NAME=Android \
  -DANDROID_ARM_NEON=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  -DABSL_PROPAGATE_CXX_STD=ON \
  -Dprotobuf_BUILD_SHARED_LIBS=OFF \
  -Dprotobuf_BUILD_PROTOC_BINARIES=OFF \
  -Dprotobuf_BUILD_LIBPROTOC=ON \
  -DPNG_SHARED=OFF \
  -DZLIB_USE_STATIC_LIBS=ON
  
# Build the binary
ninja -C build aapt2

# Remove debug symbol
"$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip" --strip-unneeded  "build/bin/aapt2-$architecture"
