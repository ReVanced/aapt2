add_executable(aapt ${SRC_PATH}/aapt/Main.cpp
    ${SRC_PATH}/aapt/AaptAssets.cpp
    ${SRC_PATH}/aapt/AaptConfig.cpp
    ${SRC_PATH}/aapt/AaptUtil.cpp
    ${SRC_PATH}/aapt/AaptXml.cpp
    ${SRC_PATH}/aapt/ApkBuilder.cpp
    ${SRC_PATH}/aapt/Command.cpp
    ${SRC_PATH}/aapt/CrunchCache.cpp
    ${SRC_PATH}/aapt/FileFinder.cpp
    ${SRC_PATH}/aapt/Images.cpp
    ${SRC_PATH}/aapt/Package.cpp
    ${SRC_PATH}/aapt/pseudolocalize.cpp
    ${SRC_PATH}/aapt/Resource.cpp
    ${SRC_PATH}/aapt/ResourceFilter.cpp
    ${SRC_PATH}/aapt/ResourceIdCache.cpp
    ${SRC_PATH}/aapt/ResourceTable.cpp
    ${SRC_PATH}/aapt/SourcePos.cpp
    ${SRC_PATH}/aapt/StringPool.cpp
    ${SRC_PATH}/aapt/WorkQueue.cpp
    ${SRC_PATH}/aapt/XMLNode.cpp
    ${SRC_PATH}/aapt/ZipEntry.cpp
    ${SRC_PATH}/aapt/ZipFile.cpp
    )

target_compile_definitions(aapt PRIVATE
    -DSTATIC_ANDROIDFW_FOR_TOOLS
    )

target_include_directories(aapt PUBLIC
    ${SRC_PATH}/androidfw/include
    ${SRC_PATH}/expat
    ${SRC_PATH}/fmtlib/include
    ${SRC_PATH}/libpng
    ${SRC_PATH}/libbase/include
    ${SRC_PATH}/libutils/include
    ${SRC_PATH}/libsystem/include
    ${SRC_PATH}/liblog/include
    ${SRC_PATH}/incfs/util/include 
    ${SRC_PATH}/incfs/kernel-headers
    )

target_link_libraries(aapt
    libandroidfw
    libincfs
    libutils
    libcutils
    libselinux
    libziparchive
    libbase
    libprocessgroup
    liblog
    libexpat
    crypto
    libjson
    libpng
    c++_static
    z
    )
    
    