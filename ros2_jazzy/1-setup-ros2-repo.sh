#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=jazzy
. ../ros2/lib.sh

ros2_repo_setup
