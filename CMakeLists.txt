cmake_minimum_required(VERSION 3.14.2)

project(aapt2)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu++2a")
set(CMAKE_EXE_LINKER_FLAGS "-static")
set(SRC ${PROJECT_SOURCE_DIR}/src)

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

if(NOT EXISTS ${SRC}/incremental_delivery/sysprop/include)
    execute_process(
        COMMAND mkdir src/incremental_delivery/sysprop/include
        COMMAND cp patches/IncrementalProperties.sysprop.h src/incremental_delivery/sysprop/include
        COMMAND cp patches/IncrementalProperties.sysprop.cpp src/incremental_delivery/sysprop
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
endif()

add_subdirectory(src/pcre EXCLUDE_FROM_ALL)
add_subdirectory(src/expat EXCLUDE_FROM_ALL)

set(OPENSSL_USE_STATIC_LIBS TRUE)
find_package(OpenSSL REQUIRED)
target_link_libraries(${PROJECT_NAME} OpenSSL::Crypto)
target_link_libraries(${PROJECT_NAME} OpenSSL::SSL)

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
#include(cmake/libexpat.cmake)
#include(cmake/libpcre.cmake)

# Others potentially required by dependencies of aapt2
include(cmake/libfmt.cmake)
include(cmake/libzopfli.cmake)
include(cmake/libprocessgroup.cmake)
include(cmake/libjson.cmake)

# aapt2 itself
include(cmake/aapt2.cmake)