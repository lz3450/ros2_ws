if [[ -z "$ROS2_SETUP" ]]; then
    echo "ROS2 is not sourced. Please source ros2_setup.sh first"
    return 1
fi

if [[ -z "$MOVEIT2_SETUP" ]]; then
    echo "MoveIt2 is not sourced. Please source moveit2_setup.sh first"
    return 1
fi

XARM_SETUP="$ROS2_WS/xarm_humble/install/local_setup.$ROS2_SHELL"
if [[ -f "$XARM_SETUP" ]]; then
    echo "xarm ($ROS2_SHELL)"
    . "$XARM_SETUP"
else
    echo "failed to set up xarm_humble"
    return 1
fi
