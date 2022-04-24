add_library(libjson STATIC
    ${SRC}/jsoncpp/src/lib_json/json_reader.cpp
    ${SRC}/jsoncpp/src/lib_json/json_value.cpp
    ${SRC}/jsoncpp/src/lib_json/json_writer.cpp
    ${SRC}/jsoncpp/src/lib_json/json_valueiterator.inl
    )
    
target_compile_definitions(libjson PRIVATE
    -DJSON_USE_EXCEPTION=0
    -DJSONCPP_NO_LOCALE_SUPPORT
    )
    
target_include_directories(libjson PUBLIC
    ${SRC}/jsoncpp/include
    )