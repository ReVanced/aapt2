add_library(libprocessgroup STATIC
    ${SRC}/core/libprocessgroup/cgroup_map.cpp
    ${SRC}/core/libprocessgroup/processgroup.cpp
    ${SRC}/core/libprocessgroup/sched_policy.cpp
    ${SRC}/core/libprocessgroup/task_profiles.cpp
    ${SRC}/core/libprocessgroup/cgrouprc_format/cgroup_controller.cpp
    ${SRC}/core/libprocessgroup/cgrouprc/cgroup_controller.cpp
    ${SRC}/core/libprocessgroup/cgrouprc/cgroup_file.cpp
    )

target_include_directories(libprocessgroup PRIVATE
    ${SRC}/core/libprocessgroup/include
    ${SRC}/core/libprocessgroup/cgrouprc/include
    ${SRC}/core/libprocessgroup/cgrouprc_format/include
    ${SRC}/core/libprocessgroup/util/include
    ${SRC}/libbase/include
    ${SRC}/core/libcutils/include
    ${SRC}/jsoncpp/include
    )
target_include_directories(libprocessgroup PRIVATE
    ${SRC}/core/libprocessgroup
    )
