if [ -n "$BASH_VERSION" ]; then
    export ROS2_WS="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1; pwd -P)"
    shell="bash"
elif [ -n "$ZSH_VERSION" ]; then
    export ROS2_WS="$(cd -- "$(dirname "${(%):-%x}")" >/dev/null 2>&1; pwd -P)"
    shell="zsh"
else
  echo "Unsupported shell"
fi
echo "ros2_ws: $ROS2_WS"

ROS2_SETUP="$ROS2_WS/ros2_jazzy/install/local_setup.$shell"
if [[ -f "$ROS2_SETUP" ]]; then
    export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_jazzy ($shell)"
    . "$ROS2_SETUP"
fi

MOVEIT2_WS_SETUP="$ROS2_WS/moveit2"
if [[ -f "$MOVEIT2_WS_SETUP/install/local_setup.$shell" ]]; then
    echo "moveit2 ($shell)"
    . "$MOVEIT2_WS_SETUP/install/local_setup.$shell"
fi
