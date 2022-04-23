add_executable(zipalign ${SRC}/zipalign/ZipAlignMain.cpp
    ${SRC}/zipalign/ZipAlign.cpp
    ${SRC}/zipalign/ZipEntry.cpp
    ${SRC}/zipalign/ZipFile.cpp
    )

target_include_directories(zipalign PUBLIC
    ${SRC}/libbase/include
    ${SRC}/logging/liblog/include
    ${SRC}/core/libutils/include
    ${SRC}/libziparchive/include
    )

target_include_directories(zipalign PRIVATE
    ${SRC}/zipalign/include
    ${SRC}/zopfli/src
    )

target_link_libraries(zipalign 
    libutils 
    libbase
    libziparchive
    libzopfli
    liblog
    c++_static
    z
    )
