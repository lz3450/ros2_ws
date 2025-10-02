#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

get_tb4_src

rm -rf src/create3_examples/{create3_coverage,create3_examples_msgs,create3_examples_py,create3_lidar_slam,create3_teleop}
rm -rf src/depthai-ros/{depthai-ros,depthai_filters}
rm -rf src/foxglove-sdk/ros/src/foxglove_bridge
rm -rf src/image_transport_plugins/{zstd_image_transport}
rm -rf src/create3_sim/irobot_create_common/{irobot_create_common_bringup,irobot_create_nodes,irobot_create_toolbox}
rm -rf src/create3_sim/{irobot_create_gazebo,irobot_create_ignition}
rm -rf src/joystick_drivers/{joystick_drivers,ps3joy,spacenav,wiimote,wiimote_msgs}
rm -rf src/imu_tools/{imu_complementary_filter,imu_filter_madgwick,imu_tools}
rm -rf src/vision_msgs/vision_msgs_rviz_plugins
rm -rf src/vision_opencv/{cv_bridge,opencv_tests,vision_opencv}

echo "Successfully updated TurtleBot4 (robot) source code and applied patches"
