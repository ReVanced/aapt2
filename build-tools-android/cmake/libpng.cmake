add_library(libpng STATIC
    ${SRC_PATH}/libpng/png.c
    ${SRC_PATH}/libpng/pngerror.c
    ${SRC_PATH}/libpng/pngget.c
    ${SRC_PATH}/libpng/pngmem.c
    ${SRC_PATH}/libpng/pngpread.c
    ${SRC_PATH}/libpng/pngread.c
    ${SRC_PATH}/libpng/pngrio.c
    ${SRC_PATH}/libpng/pngrtran.c
    ${SRC_PATH}/libpng/pngrutil.c
    ${SRC_PATH}/libpng/pngset.c
    ${SRC_PATH}/libpng/pngtrans.c
    ${SRC_PATH}/libpng/pngwio.c
    ${SRC_PATH}/libpng/pngwrite.c
    ${SRC_PATH}/libpng/pngwtran.c
    ${SRC_PATH}/libpng/pngwutil.c
    )
    
if(${ARCH} STREQUAL "arm64-v8a" OR ${ARCH} STREQUAL "armeabi-v7a")
target_sources(libpng PUBLIC
    ${SRC_PATH}/libpng/arm/arm_init.c
    ${SRC_PATH}/libpng/arm/filter_neon_intrinsics.c
    ${SRC_PATH}/libpng/arm/palette_neon_intrinsics.c
    )
    
if(${ARCH} STREQUAL "armeabi-v7a")
target_sources(libpng PUBLIC
    ${SRC_PATH}/libpng/arm/filter_neon.S
    )
endif()

elseif(${ARCH} STREQUAL "x86-64" OR ${ARCH} STREQUAL "x86")
target_sources(libpng PUBLIC
    ${SRC_PATH}/libpng/intel/intel_init.c
    ${SRC_PATH}/libpng/intel/filter_sse2_intrinsics.c
    )
    
target_compile_definitions(libpng PRIVATE
    -DPNG_INTEL_SSE_OPT=1
    )
endif()
        
target_include_directories(libpng PRIVATE
    ${SRC_PATH}/libpng
    )