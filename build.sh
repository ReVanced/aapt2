cd termux-packages
./scripts/run-docker.sh ../setup.sh
for arch in "aarch64" "arm" "i686"; do
  echo "Building aapt for $arch"
  ./scripts/run-docker.sh ./build-package.sh -I -a $arch aapt
done