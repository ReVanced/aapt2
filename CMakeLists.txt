cmake_minimum_required(VERSION 3.14.2)
project(build-tools)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 23)

if(ANDROID_ABI STREQUAL "arm64-v8a" OR ANDROID_ABI STREQUAL "armeabi-v7a")
    enable_language(ASM)
elseif(ANDROID_ABI STREQUAL "x86_64" OR ANDROID_ABI STREQUAL "x86")
    enable_language(ASM_NASM)
else()
    message(FATAL_ERROR "Unsupported architecture: ${ANDROID_ABI}")
endif()

# set global cflags and cxxflags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics -fPIC -Wno-attributes -std=gnu++23")
# static link
set(CMAKE_EXE_LINKER_FLAGS "-static")

# platform tools version
# see the misc/platform_tools_version.h
set(TOOLS_VERSION 37.0.0)
set(SRC ${PROJECT_SOURCE_DIR}/submodules)

# 64-bit off_t for lseek.
add_definitions(-D_FILE_OFFSET_BITS=64)

# expat (Android 17) menolak dikompilasi bila tidak ada sumber entropi yang
# terdeteksi (error di xmlparse.c:149). Paksa pakai /dev/urandom, tersedia di Android.
add_definitions(-DXML_DEV_URANDOM)

# protoc options
set(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_PROTOC_BINARIES OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_LIBPROTOC ON CACHE BOOL "" FORCE)

# thrid-party libraries
add_subdirectory(submodules/boringssl EXCLUDE_FROM_ALL)
add_subdirectory(submodules/fmtlib EXCLUDE_FROM_ALL)
add_subdirectory(submodules/pcre EXCLUDE_FROM_ALL)
add_subdirectory(submodules/libpng EXCLUDE_FROM_ALL)
add_subdirectory(submodules/jsoncpp EXCLUDE_FROM_ALL)
add_subdirectory(submodules/expat/expat EXCLUDE_FROM_ALL)
# patches/protobuf.patch lama menambahkan folder android/ ke include path protobuf
if(EXISTS ${PROJECT_SOURCE_DIR}/submodules/protobuf/android)
    include_directories(${PROJECT_SOURCE_DIR}/submodules/protobuf/android)
endif()
add_subdirectory(submodules/protobuf EXCLUDE_FROM_ALL)
add_subdirectory(submodules/googletest EXCLUDE_FROM_ALL)

# Opsi compiler khusus kode AOSP (library pihak ketiga di atas tidak ikut terpengaruh).
#  - __ANDROID_UNAVAILABLE_SYMBOLS_ARE_WEAK__: API baru Android 17 di header liblog dll
#    ("unavailable: introduced in Android 37") jadi peringatan, bukan error.
#  - -Wno-invalid-constexpr: LocaleDataLookup.h memakai reinterpret_cast di constexpr.
add_compile_options(
    "$<$<COMPILE_LANGUAGE:C,CXX>:-D__ANDROID_UNAVAILABLE_SYMBOLS_ARE_WEAK__>"
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-invalid-constexpr>")

# building sdk-tools
add_subdirectory(cmake)

# bionic_compat.h (deklarasi fungsi property yang tidak ada di header publik NDK r27)
# hanya di-include paksa ke 4 file ini. Jangan global: include paksa membuat <sys/cdefs.h>
# terbaca sebelum file seperti libbase/posix_strerror_r.cpp sempat #undef _GNU_SOURCE.
set_source_files_properties(
    ${SRC}/libbase/properties.cpp
    ${SRC}/logging/liblog/properties.cpp
    ${SRC}/core/libcutils/trace-dev.cpp
    ${SRC}/selinux/libselinux/src/android/android_device.c
    TARGET_DIRECTORY libbase liblog libcutils libselinux
    PROPERTIES COMPILE_OPTIONS "-include;${PROJECT_SOURCE_DIR}/misc/bionic_compat.h")

# abseil (FetchContent, dipakai protobuf 33.x) menambahkan "-llog" untuk Android. Link kita
# `-static` dan NDK hanya punya liblog.so, jadi -llog gagal ("unable to find library -llog").
# Solusi: liblog AOSP yang sudah ikut dibuild dinamai liblog.a dan folder lib/ didaftarkan
# sebagai search path link, sehingga -llog memakai liblog tersebut.
set_target_properties(liblog PROPERTIES OUTPUT_NAME log)
target_link_directories(aapt2 PRIVATE ${CMAKE_BINARY_DIR}/lib)
