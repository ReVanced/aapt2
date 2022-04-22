add_library(libexpat STATIC
    ${SRC_PATH}/expat/xmlparse.c
    ${SRC_PATH}/expat/xmlrole.c
    ${SRC_PATH}/expat/xmltok.c
    )
    
target_compile_definitions(libexpat PRIVATE
    -DHAVE_EXPAT_CONFIG_H
    )
        
target_include_directories(libexpat PUBLIC
    ${SRC_PATH}/expat
    )