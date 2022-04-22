add_library(liblog STATIC
    ${SRC_PATH}/liblog/log_event_list.cpp
    ${SRC_PATH}/liblog/log_event_write.cpp
    ${SRC_PATH}/liblog/logger_name.cpp
    ${SRC_PATH}/liblog/logger_read.cpp
    ${SRC_PATH}/liblog/logger_write.cpp
    ${SRC_PATH}/liblog/properties.cpp
    ${SRC_PATH}/liblog/logprint.cpp
    ${SRC_PATH}/liblog/event_tag_map.cpp
    ${SRC_PATH}/liblog/log_time.cpp
    ${SRC_PATH}/liblog/pmsg_reader.cpp
    ${SRC_PATH}/liblog/pmsg_writer.cpp
    ${SRC_PATH}/liblog/logd_reader.cpp
    ${SRC_PATH}/liblog/logd_writer.cpp
    )

target_compile_definitions(liblog PRIVATE
    -DLIBLOG_LOG_TAG=1006 
    -D_XOPEN_SOURCE=700 
    -DFAKE_LOG_DEVICE=1
    -DSNET_EVENT_LOG_TAG=1397638686
    )
    
target_include_directories(liblog PUBLIC
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/libutils/include 
    ${SRC_PATH}/libsystem/include
    ${SRC_PATH}/liblog/include
    ${SRC_PATH}/libbase/include
    )