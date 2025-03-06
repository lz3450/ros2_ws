#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. ../ros2/lib.sh

wget https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos -O ros2.repos
sed -i -e '/ros2\/rviz/{n; /version/s/humble/jazzy/}' ros2.repos
get_ros2_src ros2.repos
rm -vrf src/ignition
sed -i -e '/ignition_math6_vendor/d' src/ros2/rviz/rviz_default_plugins/package.xml

update_ros2_dep_pkgs
