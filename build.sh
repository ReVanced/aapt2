#!/bin/bash

# Check for NDK_TOOLCHAIN environment variable and abort if it is not set.
if [[ -z "${NDK_TOOLCHAIN}" ]]; then
    echo "Please specify the Android NDK environment variable \"NDK_TOOLCHAIN\"."
    exit 1
fi

# Prerequisites.
sudo apt install \
golang \
ninja-build \
autogen \
autoconf \
libtool \
build-essential \
-y || exit 1

root="$(pwd)"

# Install protobuf compiler.
cd "src/protobuf" || exit 1
./autogen.sh
./configure
make -j"$(nproc)"
sudo make install
sudo ldconfig

# Go back.
cd "$root" || exit 1

# Apply patches.
git apply patches/incremental_delivery.patch --whitespace=fix
git apply patches/libpng.patch --whitespace=fix
git apply patches/selinux.patch  --whitespace=fix
git apply patches/protobuf.patch --whitespace=fix
git apply patches/aapt2.patch --whitespace=fix
git apply patches/androidfw.patch --whitespace=fix
git apply patches/boringssl.patch --whitespace=fix

# Define all the compilers, libraries and targets.
api="30"
architecture=$1
declare -A compilers=(
    [x86_64]=x86_64-linux-android
    [x86]=i686-linux-android
    [arm64-v8a]=aarch64-linux-android
    [armeabi-v7a]=armv7a-linux-androideabi
)
declare -A lib_arch=(
    [x86_64]=x86_64-linux-android
    [x86]=i686-linux-android
    [arm64-v8a]=aarch64-linux-android
    [armeabi-v7a]=arm-linux-androideabi
)
declare -A target_abi=(
    [x86_64]=x86_64
    [x86]=x86
    [arm64-v8a]=aarch64
    [armeabi-v7a]=arm
)

build_directory="build"
aapt_binary_path="$root/$build_directory/cmake/aapt2"
# Build all the target architectures.
bin_directory="$root/dist/$architecture"

# switch to cmake build directory.
[[ -d dir ]] || mkdir -p $build_directory && cd $build_directory || exit 1

# Define the compiler architecture and compiler.
compiler_arch="${compilers[$architecture]}"
c_compiler="$compiler_arch$api-clang"
cxx_compiler="${c_compiler}++"

# Copy libc.a to libpthread.a.
lib_path="$NDK_TOOLCHAIN/sysroot/usr/lib/${lib_arch[$architecture]}/$api/"
cp -n "$lib_path/libc.a"  "$lib_path/libpthread.a"

# Run make for the target architecture.
compiler_bin_directory="$NDK_TOOLCHAIN/bin/"
cmake -GNinja \
-DCMAKE_C_COMPILER="$compiler_bin_directory$c_compiler" \
-DCMAKE_CXX_COMPILER="$compiler_bin_directory$cxx_compiler" \
-DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
-DCMAKE_BUILD_TYPE=Release \
-DANDROID_ABI="$architecture" \
-DTARGET_ABI="${target_abi[$architecture]}" \
-DPROTOC_PATH="/usr/local/bin/protoc" \
-DCMAKE_SYSROOT="$NDK_TOOLCHAIN/sysroot" \
.. || exit 1

ninja || exit 1

"$NDK_TOOLCHAIN/bin/llvm-strip" --strip-unneeded  "$aapt_binary_path"

# Create bin directory.
mkdir -p "$bin_directory"

# Move aapt2 to bin directory.
mv "$aapt_binary_path" "$bin_directory"
