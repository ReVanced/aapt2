add_library(libpackagelistparser STATIC
    ${SRC_PATH}/libpackagelistparser/packagelistparser.cpp
    )

target_include_directories(libpackagelistparser PUBLIC 
    ${SRC_PATH}/libpackagelistparser/include
    ${SRC_PATH}/liblog/include
    )