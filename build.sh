#!/bin/bash
set -e

# Define the targets.
API="30"
ARCHITECTURES=("armeabi-v7a" "arm64-v8a" "x86" "x86_64")

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

architecture="$1"

if [[ ! " ${ARCHITECTURES[@]} " =~ " $architecture " ]]; then
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
  -DCMAKE_SYSTEM_NAME=Android \
  -DANDROID_ARM_NEON=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DPNG_SHARED=OFF \
  -DZLIB_USE_STATIC_LIBS=ON

# Build the binary
# -k 0 = jangan berhenti di error pertama, supaya semua error muncul dalam satu log.
# Set NINJA_STOP_ON_ERROR=1 untuk berhenti di error pertama seperti biasa.
NINJA_FLAGS="-k 0"
[[ "${NINJA_STOP_ON_ERROR:-0}" == "1" ]] && NINJA_FLAGS=""

ninja -C build $NINJA_FLAGS aapt2 2>&1 | tee build.log
status=${PIPESTATUS[0]}

if [[ $status -ne 0 ]]; then
    echo
    echo "================ RINGKASAN ERROR (screenshot bagian ini) ================"
    grep -E "error:|undefined (reference|symbol)|No such file" build.log \
        | grep -v "Werror" | sed 's/\x1b\[[0-9;]*m//g' | sort -u | head -30 | cut -c1-300
    echo "========================================================================="
    exit $status
fi

# Remove debug symbol
"$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip" --strip-unneeded  "build/bin/aapt2-$architecture"
