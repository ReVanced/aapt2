#!/bin/bash

mkdir -p "src/incremental_delivery/sysprop/include/"
cp "patches/misc/IncrementalProperties.sysprop.h" "src/incremental_delivery/sysprop/include/"
cp "patches/misc/IncrementalProperties.sysprop.cpp" "src/incremental_delivery/sysprop/"

cp "patches/misc/platform_tools_version.h" "src/soong/cc/libbuildversion/include"

# As our sources are in src and not in frameworks/base/tools/aapt2 we need to change the inclusions
configPattern="s#frameworks/base/tools/aapt2/Configuration.proto#Configuration.proto#g"
ressourcesPattern="s#frameworks/base/tools/aapt2/Resources.proto#Resources.proto#g"

sed -i "$configPattern" "src/base/tools/aapt2/Resources.proto"
sed -i "$configPattern" "src/base/tools/aapt2/ResourcesInternal.proto"

sed -i "$ressourcesPattern" "src/base/tools/aapt2/ApkInfo.proto"
sed -i "$ressourcesPattern" "src/base/tools/aapt2/ResourcesInternal.proto"


# Apply modification made by IBotPeaches for apktool
git apply "patches/apktool_ibotpeaches.patch"
git apply "patches/protobuf.patch"

ln -sf "src/googletest" "src/boringssl/src/third_party/googletest"
