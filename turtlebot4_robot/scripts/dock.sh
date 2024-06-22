#!/bin/bash

if [[ -f /etc/turtlebot4/setup.bash ]]; then
    . /etc/turtlebot4/setup.bash
else
    . ../../ros2_setup.sh
fi

ros2 action send_goal /dock irobot_create_msgs/action/Dock "{}"
