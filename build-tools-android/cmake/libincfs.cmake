add_library(libincfs STATIC
    ${SRC_PATH}/incfs/incfs_ndk.c
    ${SRC_PATH}/incfs/incfs.cpp
    ${SRC_PATH}/incfs/MountRegistry.cpp
    ${SRC_PATH}/incfs/path.cpp
    ${SRC_PATH}/incfs/util/map_ptr.cpp
    ${SRC_PATH}/sysprop/IncrementalProperties.sysprop.cpp
    )
    
target_include_directories(libincfs PUBLIC
    ${SRC_PATH}/incfs/include 
    ${SRC_PATH}/incfs/util/include 
    ${SRC_PATH}/sysprop/include
    ${SRC_PATH}/incfs/kernel-headers
    ${SRC_PATH}/libbase/include
    ${SRC_PATH}/libutils/include
    ${SRC_PATH}/openssl/include
    ${SRC_PATH}/libselinux/include
    ${SRC_PATH}/liblog/include 
    )
