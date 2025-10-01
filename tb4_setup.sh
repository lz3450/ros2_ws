if [[ -z "$ROS2_SETUP" ]]; then
    echo "ROS2 is not sourced. Please source ros2_setup.sh first"
    return 1
fi

if [[ -z "$NAV2_SETUP" ]]; then
    echo "Nav2 is not sourced. Please source nav2_setup.sh first"
    return 1
fi

TB4_DESKTOP_SETUP="$ROS2_WS/turtlebot4_desktop/install/local_setup.$ROS2_SHELL"
if [[ -f "$TB4_DESKTOP_SETUP" ]]; then
    echo "turtlebot4_desktop ($ROS2_SHELL)"
    . "$TB4_DESKTOP_SETUP"
fi

TB4_ROBOT_SETUP="$ROS2_WS/turtlebot4_robot/install/local_setup.$ROS2_SHELL"
if [[ -f "$TB4_ROBOT_SETUP" ]]; then
    echo "turtlebot4_robot ($ROS2_SHELL)"
    . "$TB4_ROBOT_SETUP"

    ROBOT_SETUP="/etc/turtlebot4/setup.bash"
    if [[ -f "$ROBOT_SETUP" ]]; then
        echo "turtlebot4_setup ($ROS2_SHELL)"
        export ROBOT_SETUP
    fi
fi
