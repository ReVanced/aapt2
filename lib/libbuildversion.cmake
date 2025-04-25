add_library(libbuildversion STATIC
    ${SRC}/soong/cc/libbuildversion/libbuildversion.cpp
    )

target_include_directories(libbuildversion PRIVATE
    ${SRC}/soong/cc/libbuildversion/include
    )
