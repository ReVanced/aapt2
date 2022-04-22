cmake_minimum_required(VERSION 3.14.2)

project(build-tools-android)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu++2a")
set(CMAKE_EXE_LINKER_FLAGS "-static")
set(SRC_PATH ${PROJECT_SOURCE_DIR}/src)

if(NOT DEFINED ARCH)
    message(FATAL_ERROR "ARCH is not defined")
endif()

if(${ARCH} STREQUAL "arm64-v8a" OR ${ARCH} STREQUAL "armeabi-v7a")
    enable_language(ASM)
elseif(${ARCH} STREQUAL "x86-64" OR ${ARCH} STREQUAL "x86")
    enable_language(ASM_NASM)
else()
    message(FATAL_ERROR "Unsupported architecture: ${ARCH}")
endif()

add_library(crypto STATIC IMPORTED)
set_target_properties(crypto PROPERTIES IMPORTED_LOCATION ${SRC_PATH}/openssl/lib/${ARCH}/libcrypto.a)

add_library(ssl STATIC IMPORTED)
set_target_properties(ssl PROPERTIES IMPORTED_LOCATION ${SRC_PATH}/openssl/lib/${ARCH}/libssl.a)

# Required by aapt2
include(cmake/libandroidfw.cmake)
include(cmake/libincfs.cmake)
include(cmake/libselinux.cmake)
include(cmake/libsepol.cmake)
include(cmake/libpackagelistparser.cmake)
include(cmake/libutils.cmake)
include(cmake/libcutils.cmake)
include(cmake/libziparchive.cmake)
include(cmake/libbase.cmake)
include(cmake/libprotobuf.cmake)
include(cmake/liblog.cmake)
include(cmake/libpng.cmake)
include(cmake/libexpat.cmake)
include(cmake/libpcre.cmake)

# Others potentially required by dependencies of aapt2
include(cmake/libgtest.cmake)
include(cmake/libfmt.cmake)
include(cmake/libzopfli.cmake)
include(cmake/libprocessgroup.cmake)
include(cmake/libjson.cmake)

# aapt2 itself
include(cmake/aapt2.cmake)