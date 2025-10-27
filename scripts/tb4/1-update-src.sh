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
get_src tb4.repos "$srcdir"

rm -rf "$srcdir"/navigation2/nav2_system_tests
rm -rf "$srcdir"/bond_core/{bond_core,bondpy,test_bond}
rm -rf "$srcdir"/create3_examples/{create3_coverage,create3_examples_msgs,create3_examples_py,create3_lidar_slam,create3_teleop}
rm -rf "$srcdir"/vision_opencv/{opencv_tests,vision_opencv}
rm -rf "$srcdir"/depthai-ros/{depthai-ros,depthai_filters}
rm -rf "$srcdir"/diagnostics/{diagnostic_common_diagnostics,diagnostic_remote_logging,diagnostics,self_test}
rm -rf "$srcdir"/create3_sim/{irobot_create_gazebo,irobot_create_ignition}
rm -rf "$srcdir"/create3_sim/irobot_create_common/{irobot_create_common_bringup,irobot_create_control,irobot_create_nodes,irobot_create_toolbox}
rm -rf "$srcdir"/joystick_drivers/{joystick_drivers,ps3joy,spacenav,wiimote,wiimote_msgs}
rm -rf "$srcdir"/image_pipeline/{tracetools_image_pipeline}
rm -rf "$srcdir"/foxglove-sdk/ros/src/foxglove_bridge
rm -rf "$srcdir"/imu_tools/{imu_complementary_filter,imu_filter_madgwick,imu_tools}

echo "Successfully updated source code and applied patches"
