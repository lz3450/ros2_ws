#!/usr/bin/env bash
#
# update-deps.sh
#

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

ROS_DISTRO=humble
. ../lib.sh

get_dep_pkgs dep-pkgs.txt "$ROS2_WS/src"

echo "Successfully updated dependency package list"
