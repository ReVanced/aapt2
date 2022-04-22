add_library(libandroidfw STATIC
    ${SRC_PATH}/androidfw/ApkAssets.cpp
    ${SRC_PATH}/androidfw/Asset.cpp
    ${SRC_PATH}/androidfw/AssetDir.cpp
    ${SRC_PATH}/androidfw/AssetManager.cpp
    ${SRC_PATH}/androidfw/AssetManager2.cpp
    ${SRC_PATH}/androidfw/AttributeResolution.cpp
    ${SRC_PATH}/androidfw/ChunkIterator.cpp
    ${SRC_PATH}/androidfw/ConfigDescription.cpp
    ${SRC_PATH}/androidfw/Idmap.cpp
    ${SRC_PATH}/androidfw/LoadedArsc.cpp
    ${SRC_PATH}/androidfw/Locale.cpp
    ${SRC_PATH}/androidfw/LocaleData.cpp
    ${SRC_PATH}/androidfw/misc.cpp
    ${SRC_PATH}/androidfw/ObbFile.cpp
    ${SRC_PATH}/androidfw/PosixUtils.cpp
    ${SRC_PATH}/androidfw/ResourceTypes.cpp
    ${SRC_PATH}/androidfw/ResourceUtils.cpp
    ${SRC_PATH}/androidfw/StreamingZipInflater.cpp
    ${SRC_PATH}/androidfw/TypeWrappers.cpp
    ${SRC_PATH}/androidfw/Util.cpp
    ${SRC_PATH}/androidfw/ZipFileRO.cpp
    ${SRC_PATH}/androidfw/ZipUtils.cpp
    )

target_compile_definitions(libandroidfw PUBLIC -DSTATIC_ANDROIDFW_FOR_TOOLS)

target_compile_definitions(libandroidfw PRIVATE -D_GNU_SOURCE -DNDEBUG)

target_include_directories(libandroidfw PUBLIC
    ${SRC_PATH}/androidfw/include
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/liblog/include
    ${SRC_PATH}/libsystem/include
    ${SRC_PATH}/libutils/include
    ${SRC_PATH}/libbase/include
    ${SRC_PATH}/binder/include
    ${SRC_PATH}/libziparchive/include
    ${SRC_PATH}/incfs/util/include
    ${SRC_PATH}/incfs/kernel-headers
    )
    
target_link_libraries(libandroidfw PUBLIC
    libfmt
    )
