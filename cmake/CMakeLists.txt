# Binary
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME})
include(aapt2.cmake)

# Libraries
include(libbase.cmake)
include(liblog.cmake)
include(libcutils.cmake)
include(libutils.cmake)
include(libandroidfw.cmake)
include(libincfs.cmake)
include(libselinux.cmake)
include(libsepol.cmake)
include(libziparchive.cmake)
include(libbuildversion.cmake)
include(libpackagelistparser.cmake)
include(libprocessgroup.cmake)
