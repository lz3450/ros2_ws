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

srcdir="$ROS2_WS/src/tb4"

################################################################################
rm -rf "$srcdir"

################################################################################
get_src tb4.repos "$srcdir"

rm -rf "$srcdir"/navigation2/nav2_system_tests

###
get_src deps.repos "$srcdir"

rm -rf "$srcdir"/create3_sim/{irobot_create_gazebo,irobot_create_ignition}
rm -rf "$srcdir"/foxglove-sdk/ros/src/foxglove_bridge
find "$srcdir"/joystick_drivers -mindepth 1 -maxdepth 1 -type d \
    ! -name 'joy' \
    ! -name 'joy_linux' \
    ! -name 'sdl2_vendor' \
    -exec rm -rf {} +

# rm -rf "$srcdir"/bond_core/{bond_core,bondpy,test_bond}

# rm -rf "$srcdir"/create3_examples/{create3_coverage,create3_examples_msgs,create3_examples_py,create3_lidar_slam,create3_teleop}
# rm -rf "$srcdir"/create3_sim/irobot_create_common/{irobot_create_common_bringup,irobot_create_nodes,irobot_create_toolbox}
# rm -rf "$srcdir"/depthai-ros/{depthai-ros,depthai_filters}
# rm -rf "$srcdir"/diagnostics/{diagnostic_common_diagnostics,diagnostic_remote_logging,diagnostics,self_test}
# rm -rf "$srcdir"/image_pipeline/{tracetools_image_pipeline}
# rm -rf "$srcdir"/imu_tools/{imu_complementary_filter,imu_filter_madgwick,imu_tools}
# rm -rf "$srcdir"/vision_opencv/{opencv_tests,vision_opencv}
# find "$srcdir"/ros2_control -mindepth 1 -maxdepth 1 -type d \
#     ! -name 'controller_interface' \
#     ! -name 'controller_manager' \
#     ! -name 'hardware_interface' \
#     ! -name 'hardware_interface_testing' \
#     ! -name 'ros2_control_test_assets' \
#     -exec rm -rf {} +
# find "$srcdir"/ros2_controllers -mindepth 1 -maxdepth 1 -type d \
#     ! -name 'joint_state_broadcaster' \
#     ! -name 'ros2_controllers' \
#     -exec rm -rf {} +

###
echo "Successfully updated source code and applied patches"

################################################################################
get_dep_pkgs dep-pkgs.txt "$ROS2_WS/src"

###
echo "Successfully updated dependency package list"
