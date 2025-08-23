#!/bin/bash

mkdir -p "submodules/incremental_delivery/sysprop/include/"
cp "misc/IncrementalProperties.sysprop.h" "submodules/incremental_delivery/sysprop/include/"
cp "misc/IncrementalProperties.sysprop.cpp" "submodules/incremental_delivery/sysprop/"

cp "misc/platform_tools_version.h" "submodules/soong/cc/libbuildversion/include"

# As our sources are in submodules and not in frameworks/base/tools/aapt2 we need to change the inclusions
configPattern="s#frameworks/base/tools/aapt2/Configuration.proto#Configuration.proto#g"
ressourcesPattern="s#frameworks/base/tools/aapt2/Resources.proto#Resources.proto#g"

sed -i "$configPattern" "submodules/base/tools/aapt2/Resources.proto"
sed -i "$configPattern" "submodules/base/tools/aapt2/ResourcesInternal.proto"

sed -i "$ressourcesPattern" "submodules/base/tools/aapt2/ApkInfo.proto"
sed -i "$ressourcesPattern" "submodules/base/tools/aapt2/ResourcesInternal.proto"


# Apply modification made by IBotPeaches for apktool
git apply "patches/apktool_ibotpeaches.patch"
git apply "patches/protobuf.patch"

ln -sf "submodules/googletest" "submodules/boringssl/src/third_party/googletest"
