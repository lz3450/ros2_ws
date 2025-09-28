if [[ -z "$ROS2_SETUP" ]]; then
    echo "ROS2 is not sourced. Please source ros2_setup.sh first"
    return 1
fi

NAV2_SETUP="$ROS2_WS/nav2_humble/install/local_setup.$ROS2_SHELL"
if [[ -f "$NAV2_SETUP" ]]; then
    echo "nav2_humble ($ROS2_SHELL)"
    . "$NAV2_SETUP"
else
    echo "failed to set up nav2_humble"
    return 1
fi
