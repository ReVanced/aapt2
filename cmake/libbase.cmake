add_library(libbase STATIC
    ${SRC}/libbase/abi_compatibility.cpp
    ${SRC}/libbase/chrono_utils.cpp
    ${SRC}/libbase/cmsg.cpp
    ${SRC}/libbase/errors_unix.cpp
    ${SRC}/libbase/file.cpp
    ${SRC}/libbase/logging.cpp
    ${SRC}/libbase/mapped_file.cpp
    ${SRC}/libbase/parsebool.cpp
    ${SRC}/libbase/parsenetaddress.cpp
    ${SRC}/libbase/posix_strerror_r.cpp
    ${SRC}/libbase/process.cpp
    ${SRC}/libbase/properties.cpp
    ${SRC}/libbase/stringprintf.cpp
    ${SRC}/libbase/strings.cpp
    ${SRC}/libbase/test_utils.cpp
    ${SRC}/libbase/threads.cpp
    )

target_include_directories(libbase PRIVATE
    ${SRC}/libbase/include 
    ${SRC}/core/include 
    ${SRC}/logging/liblog/include
    )

target_link_options(libbase PRIVATE "-Wl,-z,max-page-size=16384")
