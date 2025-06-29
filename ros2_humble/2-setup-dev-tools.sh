#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. ../ros2/lib.sh

update_ros2_dev_tools_dep_pkgs
install_ros2_dev_tools_dep_pkgs

echo "Successfully set up ROS 2 $ROS_DISTRO development tools dependencies"