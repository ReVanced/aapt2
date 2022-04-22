add_library(libzopfli STATIC
    ${SRC_PATH}/zopfli/src/zopfli/blocksplitter.c
    ${SRC_PATH}/zopfli/src/zopfli/cache.c
    ${SRC_PATH}/zopfli/src/zopfli/deflate.c
    ${SRC_PATH}/zopfli/src/zopfli/gzip_container.c
    ${SRC_PATH}/zopfli/src/zopfli/hash.c
    ${SRC_PATH}/zopfli/src/zopfli/katajainen.c
    ${SRC_PATH}/zopfli/src/zopfli/lz77.c
    ${SRC_PATH}/zopfli/src/zopfli/squeeze.c
    ${SRC_PATH}/zopfli/src/zopfli/tree.c
    ${SRC_PATH}/zopfli/src/zopfli/util.c
    ${SRC_PATH}/zopfli/src/zopfli/zlib_container.c
    ${SRC_PATH}/zopfli/src/zopfli/zopfli_lib.c
    )
    
target_include_directories(libzopfli PRIVATE
    ${SRC_PATH}/zopfli/src
    )