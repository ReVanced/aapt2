add_library(libpcre STATIC
    ${SRC_PATH}/pcre/dist2/src/pcre2_auto_possess.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_compile.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_config.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_context.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_convert.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_dfa_match.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_error.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_extuni.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_find_bracket.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_maketables.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_match.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_match_data.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_jit_compile.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_newline.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_ord2utf.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_pattern_info.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_script_run.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_serialize.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_string_utils.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_study.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_substitute.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_substring.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_tables.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_ucd.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_valid_utf.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_xclass.c
    ${SRC_PATH}/pcre/dist2/src/pcre2_chartables.c
    )
    
target_compile_definitions(libpcre PUBLIC
    -DHAVE_CONFIG_H
    )
        
target_include_directories(libpcre PUBLIC
    ${SRC_PATH}/pcre/dist2/src
    ${SRC_PATH}/pcre/include_internal
    ${SRC_PATH}/pcre/include
    )