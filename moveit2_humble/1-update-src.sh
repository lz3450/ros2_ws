#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

init_mixin

get_moveit2_src

rm -rf src/ros2_control/rqt_controller_manager
rm -rf src/vision_opencv/{image_geometry,opencv_tests,vision_opencv}
rm -rf src/generate_parameter_library/{example,example_cmake_python,example_external,example_python}
rm -rf src/ros2_controllers/{ackermann_steering_controller,admittance_controller,bicycle_steering_controller,chained_filter_controller,diff_drive_controller,effort_controllers,force_torque_sensor_broadcaster,gpio_controllers,gps_sensor_broadcaster,imu_sensor_broadcaster,mecanum_drive_controller,motion_primitives_controllers,omni_wheel_drive_controller,parallel_gripper_controller,pid_controller,pose_broadcaster,range_sensor_broadcaster,ros2_controllers,ros2_controllers_test_nodes,rqt_joint_trajectory_controller,steering_controllers_library,tricycle_controller,tricycle_steering_controller,velocity_controllers}
rm -rf src/joystick_drivers/{joystick_drivers,ps3joy,spacenav,wiimote,wiimote_msgs}
rm -rf src/diagnostics/{diagnostic_aggregator,diagnostic_common_diagnostics,diagnostic_remote_logging,diagnostics,self_test}

# for patch in $(find patches -type f -name "*.patch"); do
#   repo=$(basename "$patch" .patch)
#   echo "Applying patch: $patch to src/$repo"
#   git -C "src/$repo" apply "../../$patch"
# done
# unset patch repo

# git -C "src/geometric_shapes" apply ../../patches/geometric_shapes.patch
# git -C "src/moveit2" apply ../../patches/moveit2.patch
# git -C "src/moveit2_tutorials" apply ../../patches/moveit2_tutorials.patch
# git -C "src/moveit_task_constructor" apply ../../patches/moveit_task_constructor.patch
# git -C "src/moveit_visual_tools" apply ../../patches/moveit_visual_tools.patch

echo "Successfully updated MoveIt2 source code and applied patches"
