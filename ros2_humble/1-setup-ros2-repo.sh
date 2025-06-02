#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. ../ros2/lib.sh

setup_ros2_repo
