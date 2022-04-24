add_library(libziparchive STATIC
    ${SRC}/libziparchive/zip_archive.cc
    ${SRC}/libziparchive/zip_archive_stream_entry.cc
    ${SRC}/libziparchive/zip_cd_entry_map.cc
    ${SRC}/libziparchive/zip_writer.cc
    ${SRC}/libziparchive/zip_error.cpp
    )

target_compile_definitions(libziparchive PRIVATE 
    -DZLIB_CONST
    -D_FILE_OFFSET_BITS=64
    )
    
target_include_directories(libziparchive PUBLIC
    ${SRC}/libziparchive/include 
    ${SRC}/libziparchive/incfs_support/include 
    ${SRC}/libbase/include 
    ${SRC}/logging/liblog/include
    ${SRC}/boringssl/third_party/googletest/include
    )