add_library(libjson STATIC
    ${SRC_PATH}/jsoncpp/src/json_reader.cpp
    ${SRC_PATH}/jsoncpp/src/json_value.cpp
    ${SRC_PATH}/jsoncpp/src/json_writer.cpp
    ${SRC_PATH}/jsoncpp/src/json_valueiterator.inl
    )
    
target_compile_definitions(libjson PRIVATE
    -DJSON_USE_EXCEPTION=0
    -DJSONCPP_NO_LOCALE_SUPPORT
    )
    
target_include_directories(libjson PUBLIC
    ${SRC_PATH}/jsoncpp/include
    )