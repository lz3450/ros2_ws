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
    echo "ros2_ws: $ROS2_WS"
fi

. "$ROS2_WS/ros2_setup.sh"

NAV2_SETUP="$ROS2_WS/nav2_humble"
if [[ -f "$NAV2_SETUP/install/local_setup.$shell" ]]; then
    echo "nav2 ($shell)"
    . "$NAV2_SETUP/install/local_setup.$shell"
fi
