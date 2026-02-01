add_library(libpackagelistparser STATIC
${SRC}/core/libpackagelistparser/packagelistparser.cpp
)

target_include_directories(libpackagelistparser PRIVATE
${SRC}/core/libpackagelistparser/include
${SRC}/logging/liblog/include
)

target_link_options(libpackagelistparser PRIVATE "-Wl,-z,max-page-size=16384")