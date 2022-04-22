add_library(libprocessgroup STATIC
    ${SRC_PATH}/libprocessgroup/cgroup_map.cpp
    ${SRC_PATH}/libprocessgroup/processgroup.cpp
    ${SRC_PATH}/libprocessgroup/sched_policy.cpp
    ${SRC_PATH}/libprocessgroup/task_profiles.cpp
    ${SRC_PATH}/libprocessgroup/cgrouprc_format/cgroup_controller.cpp
    ${SRC_PATH}/libprocessgroup/cgrouprc/cgroup_controller.cpp
    ${SRC_PATH}/libprocessgroup/cgrouprc/cgroup_file.cpp
    )

target_include_directories(libprocessgroup PUBLIC 
    ${SRC_PATH}/libprocessgroup/include
    ${SRC_PATH}/libprocessgroup/cgrouprc/include
    ${SRC_PATH}/libprocessgroup/cgrouprc_format/include
    ${SRC_PATH}/libbase/include
    ${SRC_PATH}/libcutils/include
    ${SRC_PATH}/jsoncpp/include
    )
    
target_include_directories(libprocessgroup PRIVATE
    ${SRC_PATH}/libprocessgroup
    )