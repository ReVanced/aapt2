add_library(libpng STATIC
    ${SRC}/libpng/png.c
    ${SRC}/libpng/pngerror.c
    ${SRC}/libpng/pngget.c
    ${SRC}/libpng/pngmem.c
    ${SRC}/libpng/pngpread.c
    ${SRC}/libpng/pngread.c
    ${SRC}/libpng/pngrio.c
    ${SRC}/libpng/pngrtran.c
    ${SRC}/libpng/pngrutil.c
    ${SRC}/libpng/pngset.c
    ${SRC}/libpng/pngtrans.c
    ${SRC}/libpng/pngwio.c
    ${SRC}/libpng/pngwrite.c
    ${SRC}/libpng/pngwtran.c
    ${SRC}/libpng/pngwutil.c)
    
if(ANDROID_ABI STREQUAL "arm64-v8a" OR ANDROID_ABI STREQUAL "armeabi-v7a")
    target_sources(libpng PRIVATE
        ${SRC}/libpng/arm/arm_init.c
        ${SRC}/libpng/arm/filter_neon_intrinsics.c
        ${SRC}/libpng/arm/palette_neon_intrinsics.c)
    
if(ANDROID_ABI STREQUAL "armeabi-v7a")
    target_sources(libpng PRIVATE ${SRC}/libpng/arm/filter_neon.S)
endif()

elseif(ANDROID_ABI STREQUAL "x86_64" OR ANDROID_ABI STREQUAL "x86")
    target_sources(libpng PRIVATE
        ${SRC}/libpng/intel/intel_init.c
        ${SRC}/libpng/intel/filter_sse2_intrinsics.c)
    
    target_compile_definitions(libpng PRIVATE -DPNG_INTEL_SSE_OPT=1)
endif()
        
target_include_directories(libpng PRIVATE ${SRC}/libpng)

target_link_options(libpng PRIVATE "-Wl,-z,max-page-size=16384")