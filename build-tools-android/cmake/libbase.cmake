add_library(libbase STATIC
    ${SRC_PATH}/libbase/abi_compatibility.cpp
    ${SRC_PATH}/libbase/chrono_utils.cpp
    ${SRC_PATH}/libbase/cmsg.cpp
    ${SRC_PATH}/libbase/errors_unix.cpp
    ${SRC_PATH}/libbase/file.cpp
    ${SRC_PATH}/libbase/logging.cpp
    ${SRC_PATH}/libbase/mapped_file.cpp
    ${SRC_PATH}/libbase/parsebool.cpp
    ${SRC_PATH}/libbase/parsenetaddress.cpp
    ${SRC_PATH}/libbase/process.cpp
    ${SRC_PATH}/libbase/properties.cpp
    ${SRC_PATH}/libbase/stringprintf.cpp
    ${SRC_PATH}/libbase/strings.cpp
    ${SRC_PATH}/libbase/test_utils.cpp
    ${SRC_PATH}/libbase/threads.cpp
    )

target_compile_definitions(libbase PUBLIC
    -D_FILE_OFFSET_BITS=64
    )

target_include_directories(libbase PUBLIC
    ${SRC_PATH}/libbase/include 
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/libutils/include 
    ${SRC_PATH}/libsystem/include
    ${SRC_PATH}/liblog/include
    )