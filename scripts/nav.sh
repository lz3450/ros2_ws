#!/bin/bash

if [[ -z "$ROS_DISTRO" ]]; then
    if [[ -f /etc/turtlebot4/setup.bash ]]; then
        . /etc/turtlebot4/setup.bash
    else
        . ../../ros2_setup.sh
    fi
fi

ros2 launch turtlebot4_navigation slam.launch.py &
sleep 1
ros2 launch turtlebot4_navigation localization.launch.py map:=ecss3220.yaml &
sleep 1
ros2 launch turtlebot4_navigation nav2.launch.py &
sleep 1
ros2 launch turtlebot4_viz view_robot.launch.py &
