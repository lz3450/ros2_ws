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
get_ros2_src ros2.repos

echo "Successfully updated ROS 2 $ROS_DISTRO source code"
