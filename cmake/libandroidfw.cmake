add_library(libandroidfw STATIC
    ${SRC}/base/libs/androidfw/ApkAssets.cpp
    ${SRC}/base/libs/androidfw/Asset.cpp
    ${SRC}/base/libs/androidfw/AssetDir.cpp
    ${SRC}/base/libs/androidfw/AssetManager.cpp
    ${SRC}/base/libs/androidfw/AssetManager2.cpp
    ${SRC}/base/libs/androidfw/AttributeResolution.cpp
    ${SRC}/base/libs/androidfw/ChunkIterator.cpp
    ${SRC}/base/libs/androidfw/ConfigDescription.cpp
    ${SRC}/base/libs/androidfw/Idmap.cpp
    ${SRC}/base/libs/androidfw/LoadedArsc.cpp
    ${SRC}/base/libs/androidfw/Locale.cpp
    ${SRC}/base/libs/androidfw/LocaleData.cpp
    ${SRC}/base/libs/androidfw/misc.cpp
    ${SRC}/base/libs/androidfw/ObbFile.cpp
    ${SRC}/base/libs/androidfw/PosixUtils.cpp
    ${SRC}/base/libs/androidfw/ResourceTypes.cpp
    ${SRC}/base/libs/androidfw/ResourceUtils.cpp
    ${SRC}/base/libs/androidfw/StreamingZipInflater.cpp
    ${SRC}/base/libs/androidfw/TypeWrappers.cpp
    ${SRC}/base/libs/androidfw/Util.cpp
    ${SRC}/base/libs/androidfw/ZipFileRO.cpp
    ${SRC}/base/libs/androidfw/ZipUtils.cpp
    )

target_compile_definitions(libandroidfw PUBLIC -DSTATIC_ANDROIDFW_FOR_TOOLS)
target_compile_definitions(libandroidfw PRIVATE -D_GNU_SOURCE -DNDEBUG)

target_include_directories(libandroidfw PUBLIC
    ${SRC}/base/libs/androidfw/include
    ${SRC}/core/libcutils/include
    ${SRC}/logging/liblog/include
    ${SRC}/core/libsystem/include
    ${SRC}/core/libutils/include
    ${SRC}/libbase/include
    ${SRC}/native/include
    ${SRC}/native/libs/binder/include
    ${SRC}/libziparchive/include
    ${SRC}/incremental_delivery/incfs/util/include
    ${SRC}/incremental_delivery/incfs/kernel-headers
    )
    
target_link_libraries(libandroidfw PUBLIC libfmt)