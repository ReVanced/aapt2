cd termux-packages/output
for pkg in *.deb
do
  echo "Extracting $pkg"
  extname=$(basename $pkg .deb)
  dpkg-deb -x $pkg $extname
  cd extracted_packages/data/data/com.termux/files/usr/
  rm -r include/ share/ lib/pkgconfig/ lib/cmake/
  find bin ! -name 'aapt2' -mindepth 1 -exec rm -f {} +
  echo "Extracted $pkg to $extname"
done