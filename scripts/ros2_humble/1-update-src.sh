#!/usr/bin/env bash
#
# update-src.sh
#

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. ../lib.sh

wget https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos -O ros2_humble.repos
get_src ros2_humble.repos "$ROS2_WS/src/ros2_humble"

echo "Successfully fetched ROS2 $ROS_DISTRO source code"
