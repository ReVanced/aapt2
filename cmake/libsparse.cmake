add_library(libsparse STATIC
    ${SRC}/core/libsparse/backed_block.cpp
    ${SRC}/core/libsparse/output_file.cpp
    ${SRC}/core/libsparse/sparse.cpp
    ${SRC}/core/libsparse/sparse_crc32.cpp
    ${SRC}/core/libsparse/sparse_err.cpp
    ${SRC}/core/libsparse/sparse_read.cpp
    )

target_include_directories(libsparse PRIVATE
    ${SRC}/core/libsparse/include 
    ${SRC}/libbase/include
    )

target_link_options(libsparse PRIVATE "-Wl,-z,max-page-size=16384")