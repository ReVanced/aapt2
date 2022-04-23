add_library(libzopfli STATIC
    ${SRC}/zopfli/src/zopfli/blocksplitter.c
    ${SRC}/zopfli/src/zopfli/cache.c
    ${SRC}/zopfli/src/zopfli/deflate.c
    ${SRC}/zopfli/src/zopfli/gzip_container.c
    ${SRC}/zopfli/src/zopfli/hash.c
    ${SRC}/zopfli/src/zopfli/katajainen.c
    ${SRC}/zopfli/src/zopfli/lz77.c
    ${SRC}/zopfli/src/zopfli/squeeze.c
    ${SRC}/zopfli/src/zopfli/tree.c
    ${SRC}/zopfli/src/zopfli/util.c
    ${SRC}/zopfli/src/zopfli/zlib_container.c
    ${SRC}/zopfli/src/zopfli/zopfli_lib.c
    )
    
target_include_directories(libzopfli PRIVATE
    ${SRC}/zopfli/src
    )