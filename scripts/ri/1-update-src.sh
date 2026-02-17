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

srcdir="$ROS2_WS/src/ri"

################################################################################
rm -rf "$srcdir"

################################################################################
get_src ri.repos "$srcdir"
get_src "$srcdir"/moveit2_tutorials/moveit2_tutorials.repos "$srcdir"
get_src "$srcdir"/moveit2/moveit2.repos "$srcdir"

###
# rm -rf "$srcdir"/navigation2/nav2_system_tests
# rm -rf "$srcdir"/xarm_ros2/{xarm_gazebo,xarm_vision}
# rm -rf "$srcdir"/xarm_ros2/thirdparty/realsense_gazebo_plugin

###
git -C "$srcdir"/moveit2 apply $(realpath --relative-to="$srcdir/moveit2" patches/moveit2.patch)
git -C "$srcdir"/moveit_task_constructor apply $(realpath --relative-to="$srcdir/moveit_task_constructor" patches/moveit_task_constructor.patch)

################################################################################
get_src deps.repos "$srcdir"

###
rm -rf "$srcdir"/kinematics_interface/kinematics_interface_pinocchio

###
echo "Successfully updated source code and applied patches"

################################################################################
get_dep_pkgs dep-pkgs.txt "$ROS2_WS/src"

###
echo "Successfully updated dependency package list"
