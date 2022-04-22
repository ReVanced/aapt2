add_library(libcutils STATIC
    ${SRC_PATH}/libcutils/android_get_control_file.cpp
    ${SRC_PATH}/libcutils/ashmem-host.cpp
    ${SRC_PATH}/libcutils/canned_fs_config.cpp
    ${SRC_PATH}/libcutils/config_utils.cpp
    ${SRC_PATH}/libcutils/fs.cpp
    ${SRC_PATH}/libcutils/fs_config.cpp
    ${SRC_PATH}/libcutils/hashmap.cpp
    ${SRC_PATH}/libcutils/iosched_policy.cpp
    ${SRC_PATH}/libcutils/load_file.cpp
    ${SRC_PATH}/libcutils/multiuser.cpp
    ${SRC_PATH}/libcutils/native_handle.cpp
    ${SRC_PATH}/libcutils/properties.cpp
    ${SRC_PATH}/libcutils/record_stream.cpp
    ${SRC_PATH}/libcutils/socket_inaddr_any_server_unix.cpp
    ${SRC_PATH}/libcutils/socket_local_client_unix.cpp
    ${SRC_PATH}/libcutils/socket_local_server_unix.cpp
    ${SRC_PATH}/libcutils/socket_network_client_unix.cpp
    ${SRC_PATH}/libcutils/sockets_unix.cpp
    ${SRC_PATH}/libcutils/sockets.cpp
    ${SRC_PATH}/libcutils/str_parms.cpp
    ${SRC_PATH}/libcutils/strlcpy.c
    ${SRC_PATH}/libcutils/trace-host.cpp
    ${SRC_PATH}/libcutils/threads.cpp
    )

target_compile_definitions(libcutils PRIVATE -D_GNU_SOURCE)

target_include_directories(libcutils PUBLIC
    ${SRC_PATH}/libutils/include
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/liblog/include 
    ${SRC_PATH}/libbase/include
    )