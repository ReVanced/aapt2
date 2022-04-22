add_library(libutils STATIC
    ${SRC_PATH}/libutils/Errors.cpp
    ${SRC_PATH}/libutils/FileMap.cpp
    ${SRC_PATH}/libutils/JenkinsHash.cpp
    ${SRC_PATH}/libutils/LightRefBase.cpp
    ${SRC_PATH}/libutils/NativeHandle.cpp
    ${SRC_PATH}/libutils/Printer.cpp
    ${SRC_PATH}/libutils/RefBase.cpp
    ${SRC_PATH}/libutils/SharedBuffer.cpp
    ${SRC_PATH}/libutils/StopWatch.cpp
    ${SRC_PATH}/libutils/String8.cpp
    ${SRC_PATH}/libutils/String16.cpp
    ${SRC_PATH}/libutils/StrongPointer.cpp
    ${SRC_PATH}/libutils/SystemClock.cpp
    ${SRC_PATH}/libutils/Threads.cpp
    ${SRC_PATH}/libutils/Timers.cpp
    ${SRC_PATH}/libutils/Tokenizer.cpp
    ${SRC_PATH}/libutils/Unicode.cpp
    ${SRC_PATH}/libutils/VectorImpl.cpp
    ${SRC_PATH}/libutils/misc.cpp
    ${SRC_PATH}/libutils/Trace.cpp
    ${SRC_PATH}/libutils/Looper.cpp
    )

target_include_directories(libutils PUBLIC
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/libutils/include 
    ${SRC_PATH}/libsystem/include
    ${SRC_PATH}/libutils/include
    ${SRC_PATH}/libprocessgroup/include
    ${SRC_PATH}/libvndksupport/include
    ${SRC_PATH}/liblog/include 
    ${SRC_PATH}/libbase/include
    ${SRC_PATH}/libbacktrace/include
    )