function buildAapt() {
  arch=$1
  python3 build.py \
    --ndk="$NDK_TOOLCHAIN" \
    --arch "$arch" \
    --build "dist/$arch" \
    --target aapt2 || exit 1
}

echo "Installing dependencies..."
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install build-essential unzip nasm cmake ninja-build -y || exit 1
echo "Downloading sources..."
wget https://github.com/Lzhiyong/sdk-tools/releases/download/33.0.1/sdk-tools-source.zip -q -O sdk-tools-source.zip
unzip -q sdk-tools-source.zip
cd sdk-tools-source

for arch in "aarch64" "arm" "x86"; do
  echo "Building aapt for $arch"
  buildAapt $arch
done