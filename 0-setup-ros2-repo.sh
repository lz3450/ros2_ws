#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. scripts/lib.sh

setup_ros2_repo

echo "Successfully set up ROS 2 $ROS_DISTRO repository"

update_ros2_dev_tools_dep_pkgs
install_ros2_dev_tools_dep_pkgs

echo "Successfully set up ROS 2 $ROS_DISTRO development tools dependencies"
