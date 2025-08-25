if [ -z "$ROS2_WS" ]; then
    echo "ROS2_WS is not set. Please source ros2_setup.sh first"
    exit 1
fi

MOVEIT2_SETUP="$ROS2_WS/moveit2_humble/install/local_setup.$shell"
if [[ -f "$MOVEIT2_SETUP" ]]; then
    echo "moveit2_humble ($shell)"
    . "$MOVEIT2_SETUP"
else
    echo "failed to set up moveit2_humble"
    exit 1
fi

export MOVEIT2_SETUP=1
