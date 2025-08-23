add_library(libcutils STATIC
    ${SRC}/core/libcutils/android_get_control_file.cpp
    ${SRC}/core/libcutils/canned_fs_config.cpp
    ${SRC}/core/libcutils/config_utils.cpp
    ${SRC}/core/libcutils/fs.cpp
    ${SRC}/core/libcutils/fs_config.cpp
    ${SRC}/core/libcutils/hashmap.cpp
    ${SRC}/core/libcutils/iosched_policy.cpp
    ${SRC}/core/libcutils/load_file.cpp
    ${SRC}/core/libcutils/multiuser.cpp
    ${SRC}/core/libcutils/native_handle.cpp
    ${SRC}/core/libcutils/properties.cpp
    ${SRC}/core/libcutils/record_stream.cpp
    ${SRC}/core/libcutils/socket_inaddr_any_server_unix.cpp
    ${SRC}/core/libcutils/socket_local_client_unix.cpp
    ${SRC}/core/libcutils/socket_local_server_unix.cpp
    ${SRC}/core/libcutils/socket_network_client_unix.cpp
    ${SRC}/core/libcutils/sockets_unix.cpp
    ${SRC}/core/libcutils/sockets.cpp
    ${SRC}/core/libcutils/str_parms.cpp
    ${SRC}/core/libcutils/strlcpy.c
    ${SRC}/core/libcutils/android_reboot.cpp
    ${SRC}/core/libcutils/ashmem-dev.cpp
    ${SRC}/core/libcutils/klog.cpp
    ${SRC}/core/libcutils/partition_utils.cpp
    ${SRC}/core/libcutils/qtaguid.cpp
    ${SRC}/core/libcutils/trace-dev.cpp
    ${SRC}/core/libcutils/uevent.cpp
    )

target_compile_definitions(libcutils PRIVATE
    -D_GNU_SOURCE
    )

target_include_directories(libcutils PRIVATE
    ${SRC}/core/libutils/include
    ${SRC}/core/libcutils/include
    ${SRC}/logging/liblog/include
    ${SRC}/libbase/include
    )
