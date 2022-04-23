add_library(libsepol STATIC
     ${SRC}/libsepol/src/assertion.c
     ${SRC}/libsepol/src/av_permissions.h
     ${SRC}/libsepol/src/avrule_block.c
     ${SRC}/libsepol/src/avtab.c
     ${SRC}/libsepol/src/boolean_internal.h
     ${SRC}/libsepol/src/boolean_record.c
     ${SRC}/libsepol/src/booleans.c
     ${SRC}/libsepol/src/conditional.c
     ${SRC}/libsepol/src/constraint.c
     ${SRC}/libsepol/src/context.c
     ${SRC}/libsepol/src/context.h
     ${SRC}/libsepol/src/context_internal.h
     ${SRC}/libsepol/src/context_record.c
     ${SRC}/libsepol/src/debug.c
     ${SRC}/libsepol/src/debug.h
     ${SRC}/libsepol/src/dso.h
     ${SRC}/libsepol/src/ebitmap.c
     ${SRC}/libsepol/src/expand.c
     ${SRC}/libsepol/src/genbools.c
     ${SRC}/libsepol/src/genusers.c
     ${SRC}/libsepol/src/handle.c
     ${SRC}/libsepol/src/handle.h
     ${SRC}/libsepol/src/hashtab.c
     ${SRC}/libsepol/src/hierarchy.c
     ${SRC}/libsepol/src/iface_internal.h
     ${SRC}/libsepol/src/iface_record.c
     ${SRC}/libsepol/src/interfaces.c
     ${SRC}/libsepol/src/libsepol.map
     ${SRC}/libsepol/src/libsepol.map.in
     ${SRC}/libsepol/src/libsepol.pc.in
     ${SRC}/libsepol/src/link.c
     ${SRC}/libsepol/src/mls.c
     ${SRC}/libsepol/src/mls.h
     ${SRC}/libsepol/src/module.c
     ${SRC}/libsepol/src/module_internal.h
     ${SRC}/libsepol/src/node_internal.h
     ${SRC}/libsepol/src/node_record.c
     ${SRC}/libsepol/src/nodes.c
     ${SRC}/libsepol/src/polcaps.c
     ${SRC}/libsepol/src/policydb.c
     ${SRC}/libsepol/src/policydb_convert.c
     ${SRC}/libsepol/src/policydb_internal.h
     ${SRC}/libsepol/src/policydb_public.c
     ${SRC}/libsepol/src/port_internal.h
     ${SRC}/libsepol/src/port_record.c
     ${SRC}/libsepol/src/ports.c
     ${SRC}/libsepol/src/private.h
     ${SRC}/libsepol/src/roles.c
     ${SRC}/libsepol/src/services.c
     ${SRC}/libsepol/src/sidtab.c
     ${SRC}/libsepol/src/symtab.c
     ${SRC}/libsepol/src/user_internal.h
     ${SRC}/libsepol/src/user_record.c
     ${SRC}/libsepol/src/users.c
     ${SRC}/libsepol/src/util.c
     ${SRC}/libsepol/src/write.c
    )

target_compile_definitions(libsepol
    PRIVATE -D_GNU_SOURCE
    )

target_include_directories(libsepol PUBLIC
    ${SRC}/selinux/include 
    ${SRC}/libsepol/include
    )
    
target_include_directories(libsepol PRIVATE
    ${SRC}/libsepol/src
    ${SRC}/libsepol/cil/include
    )