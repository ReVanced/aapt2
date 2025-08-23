add_library(libselinux STATIC
    ${SRC}/selinux/libselinux/src/android/android.c
    ${SRC}/selinux/libselinux/src/android/android_seapp.c
    ${SRC}/selinux/libselinux/src/avc.c
    ${SRC}/selinux/libselinux/src/avc_internal.c
    ${SRC}/selinux/libselinux/src/avc_sidtab.c
    ${SRC}/selinux/libselinux/src/booleans.c
    ${SRC}/selinux/libselinux/src/callbacks.c
    ${SRC}/selinux/libselinux/src/canonicalize_context.c
    ${SRC}/selinux/libselinux/src/checkAccess.c
    ${SRC}/selinux/libselinux/src/check_context.c
    ${SRC}/selinux/libselinux/src/compute_av.c
    ${SRC}/selinux/libselinux/src/compute_create.c
    ${SRC}/selinux/libselinux/src/compute_member.c
    ${SRC}/selinux/libselinux/src/context.c
    ${SRC}/selinux/libselinux/src/deny_unknown.c
    ${SRC}/selinux/libselinux/src/disable.c
    ${SRC}/selinux/libselinux/src/enabled.c
    ${SRC}/selinux/libselinux/src/fgetfilecon.c
    ${SRC}/selinux/libselinux/src/freecon.c
    ${SRC}/selinux/libselinux/src/fsetfilecon.c
    ${SRC}/selinux/libselinux/src/get_initial_context.c
    ${SRC}/selinux/libselinux/src/getenforce.c
    ${SRC}/selinux/libselinux/src/getfilecon.c
    ${SRC}/selinux/libselinux/src/getpeercon.c
    ${SRC}/selinux/libselinux/src/init.c
    ${SRC}/selinux/libselinux/src/label.c
    ${SRC}/selinux/libselinux/src/label_backends_android.c
    ${SRC}/selinux/libselinux/src/label_file.c
    ${SRC}/selinux/libselinux/src/label_support.c
    ${SRC}/selinux/libselinux/src/lgetfilecon.c
    ${SRC}/selinux/libselinux/src/load_policy.c
    ${SRC}/selinux/libselinux/src/lsetfilecon.c
    ${SRC}/selinux/libselinux/src/mapping.c
    ${SRC}/selinux/libselinux/src/matchpathcon.c
    ${SRC}/selinux/libselinux/src/policyvers.c
    ${SRC}/selinux/libselinux/src/procattr.c
    ${SRC}/selinux/libselinux/src/regex.c
    ${SRC}/selinux/libselinux/src/reject_unknown.c
    ${SRC}/selinux/libselinux/src/selinux_internal.c
    ${SRC}/selinux/libselinux/src/sestatus.c
    ${SRC}/selinux/libselinux/src/setenforce.c
    ${SRC}/selinux/libselinux/src/setfilecon.c
    ${SRC}/selinux/libselinux/src/setrans_client.c
    ${SRC}/selinux/libselinux/src/sha1.c
    ${SRC}/selinux/libselinux/src/stringrep.c
    ${SRC}/selinux/libselinux/src/android/android_device.c
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

    if(ANDROID_ABI STREQUAL "x86")
        target_compile_definitions(libselinux PRIVATE -DHAVE_STRLCPY)
    endif()

target_include_directories(libselinux PRIVATE
    ${SRC}/selinux/libselinux/include
    ${SRC}/selinux/libsepol/include
    ${SRC}/core/libcutils/include
    ${SRC}/logging/liblog/include
    ${SRC}/core/libpackagelistparser/include
    ${SRC}/pcre/include
    )

target_include_directories(libselinux PRIVATE
    ${SRC}/selinux/libselinux/src
    )
