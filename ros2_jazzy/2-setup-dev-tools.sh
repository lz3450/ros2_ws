#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=jazzy
. ../ros2/lib.sh

update_ros2_dev_tools_dep_pkgs
install_ros2_dev_tools_dep_pkgs
