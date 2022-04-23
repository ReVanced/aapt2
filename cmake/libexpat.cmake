add_library(libexpat STATIC
    ${SRC}/expat/lib/xmlparse.c
    ${SRC}/expat/lib/xmlrole.c
    ${SRC}/expat/lib/xmltok.c
    )
    
target_compile_definitions(libexpat PRIVATE
    -DHAVE_EXPAT_CONFIG_H
    )
        
target_include_directories(libexpat PUBLIC
    ${SRC}/expat
    )