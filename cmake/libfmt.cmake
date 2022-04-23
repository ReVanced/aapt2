add_library(libfmt STATIC
    ${SRC}/fmtlib/src/format.cc
    )
    
target_include_directories(libfmt PUBLIC
    ${SRC}/fmtlib/include
    )