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

MOVEIT2_SETUP="$ROS2_WS/moveit2_humble/install/local_setup.$shell"
if [[ -f "$MOVEIT2_SETUP" ]]; then
    echo "moveit2 ($shell)"
    . "$MOVEIT2_SETUP"
fi
