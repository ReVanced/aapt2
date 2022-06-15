mkdir -p /home/builder/.termux-build/aapt/src
cd /home/builder/.termux-build/aapt/src
echo "Cloning AOSP base..."
git clone --depth 1 --single-branch --branch android-12.0.0_r27 https://android.googlesource.com/platform/frameworks/base