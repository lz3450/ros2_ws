#!/bin/bash

if [[ -z "$ROS_DISTRO" ]]; then
    if [[ -f /etc/turtlebot4/setup.bash ]]; then
        . /etc/turtlebot4/setup.bash
    else
        . ../../ros2_setup.sh
    fi
fi

ros2 action send_goal /undock irobot_create_msgs/action/Undock "{}"
