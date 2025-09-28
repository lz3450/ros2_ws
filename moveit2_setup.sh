if [[ -z "$ROS2_SETUP" ]]; then
    echo "ROS2 is not sourced. Please source ros2_setup.sh first"
    return 1
fi

MOVEIT2_SETUP="$ROS2_WS/moveit2_humble/install/local_setup.$ROS2_SHELL"
if [[ -f "$MOVEIT2_SETUP" ]]; then
    echo "moveit2_humble ($ROS2_SHELL)"
    . "$MOVEIT2_SETUP"
else
    echo "failed to set up moveit2_humble"
    return 1
fi
