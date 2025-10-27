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

srcdir="$ROS2_WS/src/rg"
get_src rg.repos "$srcdir"
get_src "$srcdir"/moveit2_tutorials/moveit2_tutorials.repos "$srcdir"
get_src "$srcdir"/moveit2/moveit2.repos "$srcdir"

rm -rf "$srcdir"/navigation2/nav2_system_tests
rm -rf "$srcdir"/xarm_ros2/{xarm_gazebo,xarm_vision}
rm -rf "$srcdir"/xarm_ros2/thirdparty/realsense_gazebo_plugin
rm -rf "$srcdir"/bond_core/{bond_core,bondpy,test_bond}
rm -rf "$srcdir"/ros2_control/{doc,joint_limits_interface,rqt_controller_manager}
rm -rf "$srcdir"/vision_opencv/{image_geometry,opencv_tests,vision_opencv}
rm -rf "$srcdir"/diagnostics/{diagnostic_aggregator,diagnostic_common_diagnostics,diagnostic_remote_logging,diagnostics,self_test}
find "$srcdir"/ros2_controllers -mindepth 1 -maxdepth 1 -type d \
    ! -name 'diff_drive_controller' \
    ! -name 'gripper_controllers' \
    ! -name 'joint_state_broadcaster' \
    ! -name 'joint_trajectory_controller' \
    ! -name 'position_controllers' \
    ! -name 'forward_command_controller' \
    -exec rm -rf {} +
find "$srcdir"/generate_parameter_library -mindepth 1 -maxdepth 1 -type d \
    ! -name 'generate_parameter_library' \
    ! -name 'generate_parameter_library_py' \
    ! -name 'parameter_traits' \
    -exec rm -rf {} +
rm -rf "$srcdir"/create3_sim/{irobot_create_gazebo,irobot_create_ignition}
rm -rf "$srcdir"/create3_sim/irobot_create_common/{irobot_create_common_bringup,irobot_create_control,irobot_create_nodes,irobot_create_toolbox}
find "$srcdir"/joystick_drivers -mindepth 1 -maxdepth 1 -type d \
    ! -name 'joy' \
    ! -name 'sdl2_vendor' \
    -exec rm -rf {} +

git -C "$srcdir"/xarm_ros2 apply $(realpath --relative-to="$srcdir/xarm_ros2" patches/xarm_ros2.patch)

###
echo "Successfully updated source code and applied patches"
