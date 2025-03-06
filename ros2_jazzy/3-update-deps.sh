#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=jazzy
. ../ros2/lib.sh

wget https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos -O ros2.repos
get_ros2_src ros2.repos
### remove unused packages
# rm -vrf src/ignition

update_ros2_dep_pkgs
