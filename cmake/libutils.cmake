add_library(libutils STATIC
    ${SRC}/core/libutils/Errors.cpp
    ${SRC}/core/libutils/FileMap.cpp
    ${SRC}/core/libutils/JenkinsHash.cpp
    ${SRC}/core/libutils/LightRefBase.cpp
    ${SRC}/core/libutils/NativeHandle.cpp
    ${SRC}/core/libutils/Printer.cpp
    ${SRC}/core/libutils/RefBase.cpp
    ${SRC}/core/libutils/SharedBuffer.cpp
    ${SRC}/core/libutils/StopWatch.cpp
    ${SRC}/core/libutils/String8.cpp
    ${SRC}/core/libutils/String16.cpp
    ${SRC}/core/libutils/StrongPointer.cpp
    ${SRC}/core/libutils/SystemClock.cpp
    ${SRC}/core/libutils/Threads.cpp
    ${SRC}/core/libutils/Timers.cpp
    ${SRC}/core/libutils/Tokenizer.cpp
    ${SRC}/core/libutils/Unicode.cpp
    ${SRC}/core/libutils/VectorImpl.cpp
    ${SRC}/core/libutils/misc.cpp
    ${SRC}/core/libutils/Trace.cpp
    ${SRC}/core/libutils/Looper.cpp
    )

target_include_directories(libutils PUBLIC
    ${SRC}/core/include
    ${SRC}/core/libutils/include
    ${SRC}/core/libprocessgroup/include
    ${SRC}/core/libvndksupport/include
    ${SRC}/logging/liblog/include 
    ${SRC}/libbase/include
    ${SRC}/unwinding/libbacktrace/include
    )