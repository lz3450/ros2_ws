if [ -n "$BASH_VERSION" ]; then
    export ROS2_WS="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1; pwd -P)"
    shell="bash"
elif [ -n "$ZSH_VERSION" ]; then
    export ROS2_WS="$(cd -- "$(dirname "${(%):-%x}")" > /dev/null 2>&1; pwd -P)"
    shell="zsh"
else
  echo "Unsupported shell"
fi
echo "ros2_ws: $ROS2_WS"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.$shell"
if [[ -f "$ROS2_SETUP" ]]; then
    export RMW_IMPLEMENTATION="rmw_fastrtps_cpp"
    # export RMW_IMPLEMENTATION="rmw_cyclonedds_cpp"
    export ROS_PYTHON_VERSION=3
    echo "ros2_humble ($shell)"
    . "$ROS2_SETUP"
fi

NAV2_SETUP="$ROS2_WS/nav2_humble"
if [[ -f "$NAV2_SETUP/install/local_setup.$shell" ]]; then
    echo "nav2 ($shell)"
    . "$NAV2_SETUP/install/local_setup.$shell"
fi
