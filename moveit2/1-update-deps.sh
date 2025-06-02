#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

init_mixin

get_moveit2_src
sed -i \
    -e "/gz_ros2_control/d" \
    src/ros2_kortex/kortex_description/package.xml
sed -i \
    -e "/ros_gz_bridge/d" \
    -e "/ros_gz_sim/d" \
    src/ros2_kortex/kortex_bringup/package.xml
sed -i \
    -e '/include_directories(include)/a include_directories(SYSTEM ${stomp_INCLUDE_DIRS})' \
    src/moveit2/moveit_planners/stomp/CMakeLists.txt

update_moveit2_dep_pkgs
