add_library(libselinux STATIC
    ${SRC_PATH}/libselinux/src/booleans.c    
    ${SRC_PATH}/libselinux/src/callbacks.c    
    ${SRC_PATH}/libselinux/src/freecon.c    
    ${SRC_PATH}/libselinux/src/label_backends_android.c    
    ${SRC_PATH}/libselinux/src/label.c    
    ${SRC_PATH}/libselinux/src/label_support.c    
    ${SRC_PATH}/libselinux/src/matchpathcon.c    
    ${SRC_PATH}/libselinux/src/setrans_client.c    
    ${SRC_PATH}/libselinux/src/sha1.c    
    ${SRC_PATH}/libselinux/src/android/android.c    
    ${SRC_PATH}/libselinux/src/avc.c    
    ${SRC_PATH}/libselinux/src/avc_internal.c    
    ${SRC_PATH}/libselinux/src/avc_sidtab.c    
    ${SRC_PATH}/libselinux/src/canonicalize_context.c    
    ${SRC_PATH}/libselinux/src/checkAccess.c    
    ${SRC_PATH}/libselinux/src/check_context.c    
    ${SRC_PATH}/libselinux/src/compute_av.c    
    ${SRC_PATH}/libselinux/src/compute_create.c    
    ${SRC_PATH}/libselinux/src/compute_member.c    
    ${SRC_PATH}/libselinux/src/context.c    
    ${SRC_PATH}/libselinux/src/deny_unknown.c    
    ${SRC_PATH}/libselinux/src/disable.c    
    ${SRC_PATH}/libselinux/src/enabled.c    
    ${SRC_PATH}/libselinux/src/fgetfilecon.c    
    ${SRC_PATH}/libselinux/src/fsetfilecon.c    
    ${SRC_PATH}/libselinux/src/getenforce.c    
    ${SRC_PATH}/libselinux/src/getfilecon.c    
    ${SRC_PATH}/libselinux/src/get_initial_context.c    
    ${SRC_PATH}/libselinux/src/getpeercon.c    
    ${SRC_PATH}/libselinux/src/init.c    
    ${SRC_PATH}/libselinux/src/lgetfilecon.c    
    ${SRC_PATH}/libselinux/src/load_policy.c    
    ${SRC_PATH}/libselinux/src/lsetfilecon.c    
    ${SRC_PATH}/libselinux/src/mapping.c    
    ${SRC_PATH}/libselinux/src/policyvers.c    
    ${SRC_PATH}/libselinux/src/procattr.c    
    ${SRC_PATH}/libselinux/src/reject_unknown.c    
    ${SRC_PATH}/libselinux/src/sestatus.c    
    ${SRC_PATH}/libselinux/src/setenforce.c    
    ${SRC_PATH}/libselinux/src/setfilecon.c    
    ${SRC_PATH}/libselinux/src/stringrep.c 
    ${SRC_PATH}/libselinux/src/label_file.c
    ${SRC_PATH}/libselinux/src/regex.c
    ${SRC_PATH}/libselinux/src/selinux_config.c
    ${SRC_PATH}/libselinux/src/seusers.c
    ${SRC_PATH}/libselinux/src/android/android_vendor.c
    )

target_compile_definitions(libselinux PRIVATE
    -DAUDITD_LOG_TAG=1003 
    -D_GNU_SOURCE 
    -DHOST 
    -DUSE_PCRE2
    -DNO_PERSISTENTLY_STORED_PATTERNS 
    -DDISABLE_SETRANS
    -DDISABLE_BOOL 
    -DNO_MEDIA_BACKEND 
    -DNO_X_BACKEND 
    -DNO_DB_BACKEND
    -DPCRE2_CODE_UNIT_WIDTH=8
    )
    
target_include_directories(libselinux PUBLIC
    ${SRC_PATH}/libselinux/include 
    ${SRC_PATH}/libsepol/include
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/liblog/include 
    ${SRC_PATH}/libpackagelistparser/include
    ${SRC_PATH}/pcre/include
    )
    
target_include_directories(libselinux PRIVATE
    ${SRC_PATH}/libselinux/src
    )