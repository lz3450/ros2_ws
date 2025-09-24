if [ -z "$ROS2_WS" ]; then
    echo "ROS2_WS is not set. Please source ros2_setup.sh first"
    return 1
fi

. "$ROS2_WS/moveit2_setup.sh"

XARM_SETUP="$ROS2_WS/xarm_humble/install/local_setup.$ROS2_SHELL"
if [[ -f "$XARM_SETUP" ]]; then
    echo "xarm ($ROS2_SHELL)"
    . "$XARM_SETUP"
else
    echo "failed to set up xarm_humble"
    return 1
fi
