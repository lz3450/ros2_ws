if [ -z "$ROS2_WS" ]; then
    if [ -n "$BASH_VERSION" ]; then
        export ROS2_WS="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1; pwd -P)"
        shell="bash"
    elif [ -n "$ZSH_VERSION" ]; then
        export ROS2_WS="$(cd -- "$(dirname "${(%):-%x}")" > /dev/null 2>&1; pwd -P)"
        shell="zsh"
    else
        echo "Unsupported shell"
    fi
fi
echo "ROS2_WS=$ROS2_WS"

export ROS_DOMAIN_ID=77
echo "ROS_DOMAIN_ID=$ROS_DOMAIN_ID"
export RMW_IMPLEMENTATION="rmw_fastrtps_cpp"
# export RMW_IMPLEMENTATION="rmw_cyclonedds_cpp"
echo "RMW_IMPLEMENTATION=$RMW_IMPLEMENTATION"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.$shell"
if [[ -f "$ROS2_SETUP" ]]; then
    echo "ros2_humble ($shell)"
    . "$ROS2_SETUP"
else
    echo "failed to set up ros2_humble"
    exit 1
fi

export ROS2_SETUP=1
