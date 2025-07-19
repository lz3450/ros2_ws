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

. "$ROS2_WS/nav2_setup.sh"

TURTLEBOT4_DESKTOP_WS_SETUP="$ROS2_WS/turtlebot4_desktop"
if [[ -f "$TURTLEBOT4_DESKTOP_WS_SETUP/install/local_setup.$shell" ]]; then
    echo "turtlebot4_desktop ($shell)"
    . "$TURTLEBOT4_DESKTOP_WS_SETUP/install/local_setup.$shell"
fi

TURTLEBOT4_ROBOT_WS_SETUP="$ROS2_WS/turtlebot4_robot"
if [[ -f "$TURTLEBOT4_ROBOT_WS_SETUP/install/local_setup.$shell" ]]; then
    echo "turtlebot4_robot ($shell)"
    . "$TURTLEBOT4_ROBOT_WS_SETUP/install/local_setup.$shell"

    ROBOT_SETUP="/etc/turtlebot4/setup.bash"
    if [[ -f "$ROBOT_SETUP" ]]; then
        echo "turtlebot4_setup ($shell)"
        export ROBOT_SETUP
    fi
fi
