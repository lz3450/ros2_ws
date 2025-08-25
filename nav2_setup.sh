if [ -z "$ROS2_WS" ]; then
    echo "ROS2_WS is not set. Please source ros2_setup.sh first"
    exit 1
fi

NAV2_SETUP="$ROS2_WS/nav2_humble/install/local_setup.$shell"
if [[ -f "$NAV2_SETUP" ]]; then
    echo "nav2_humble ($shell)"
    . "$NAV2_SETUP"
else
    echo "failed to set up nav2_humble"
    exit 1
fi
