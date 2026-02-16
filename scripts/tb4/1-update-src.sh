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

ROS_DISTRO=jazzy
. ../lib.sh

srcdir="$ROS2_WS/src/tb4"

################################################################################
rm -rf "$srcdir"

################################################################################
get_src tb4.repos "$srcdir"

rm -rf "$srcdir"/navigation2/nav2_system_tests

###
get_src deps.repos "$srcdir"

rm -rf "$srcdir"/foxglove-sdk/ros/src/foxglove_bridge
find "$srcdir"/joystick_drivers -mindepth 1 -maxdepth 1 -type d \
    ! -name 'joy' \
    ! -name 'joy_linux' \
    ! -name 'sdl2_vendor' \
    -exec rm -rf {} +
rm -rf "$srcdir"/kinematics_interface/kinematics_interface_pinocchio

###
echo "Successfully updated source code and applied patches"

################################################################################
get_dep_pkgs dep-pkgs.txt "$ROS2_WS/src"

###
echo "Successfully updated dependency package list"
