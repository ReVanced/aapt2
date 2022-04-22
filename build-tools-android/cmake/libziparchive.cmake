add_library(libziparchive STATIC
    ${SRC_PATH}/libziparchive/zip_archive.cc
    ${SRC_PATH}/libziparchive/zip_archive_stream_entry.cc
    ${SRC_PATH}/libziparchive/zip_cd_entry_map.cc
    ${SRC_PATH}/libziparchive/zip_writer.cc
    ${SRC_PATH}/libziparchive/zip_error.cpp
    )

target_compile_definitions(libziparchive PRIVATE 
    -DZLIB_CONST
    -D_FILE_OFFSET_BITS=64
    )
    
target_include_directories(libziparchive PUBLIC
    ${SRC_PATH}/libziparchive/include 
    ${SRC_PATH}/libbase/include 
    ${SRC_PATH}/liblog/include
    ${SRC_PATH}/googletest/include
    )