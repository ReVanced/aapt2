add_library(libpackagelistparser STATIC
    ${SRC}/core/libpackagelistparser/packagelistparser.cpp
    )

target_include_directories(libpackagelistparser PUBLIC 
    ${SRC}/core/libpackagelistparser/include
    ${SRC}/logging/liblog/include
    )