cmake_minimum_required(VERSION 3.14.2)
project(sdk-tools)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 20)

if(ANDROID_ABI STREQUAL "arm64-v8a" OR ANDROID_ABI STREQUAL "armeabi-v7a")
    enable_language(ASM)
elseif(ANDROID_ABI STREQUAL "x86_64" OR ANDROID_ABI STREQUAL "x86")
    enable_language(ASM_NASM)
else()
    message(FATAL_ERROR "Unsupported architecture: ${ANDROID_ABI}")
endif()

# set global cflags and cxxflags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu++2a")
# static link
set(CMAKE_EXE_LINKER_FLAGS "-static")

# platform tools version
# see the patches/other/platform_tools_version.h
set(TOOLS_VERSION 35.0.2)
set(SRC ${PROJECT_SOURCE_DIR}/src)

# 64-bit off_t for lseek.
add_definitions(-D_FILE_OFFSET_BITS=64)

if(NOT DEFINED PROTOC_PATH)
    message(FATAL_ERROR "PROTOC_PATH undefined, please make sure to build and install protoc from the cloned submodule." )
endif()

set(PROTOC_COMPILER ${PROTOC_PATH})
    
if(NOT EXISTS ${PROTOC_COMPILER})
    unset(PROTOC_PATH CACHE)
    message(FATAL_ERROR "Invalid protoc: ${PROTOC_COMPILER}, please check if the path is correct")
endif()

# thrid-party libraries
add_subdirectory(src/boringssl EXCLUDE_FROM_ALL)
add_subdirectory(src/fmtlib EXCLUDE_FROM_ALL)
add_subdirectory(src/pcre EXCLUDE_FROM_ALL)
add_subdirectory(src/libpng EXCLUDE_FROM_ALL)
add_subdirectory(src/jsoncpp EXCLUDE_FROM_ALL)
add_subdirectory(src/expat/expat EXCLUDE_FROM_ALL)
add_subdirectory(src/protobuf EXCLUDE_FROM_ALL)
add_subdirectory(src/googletest EXCLUDE_FROM_ALL)

# building sdk-tools
add_subdirectory(lib)
add_subdirectory(build-tools)
