ROS2_WS="$(cd "$(dirname "${(%):-%N}")" && pwd)"
echo "ros2_ws: $ROS2_WS"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.zsh"
if [[ -f "$ROS2_SETUP" ]]; then
    # export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_humble (zsh)"
    source "$ROS2_SETUP"
fi

AT_WS="/home/kzl/Projects/AutoTrace/at_ws/install/local_setup.zsh"
if [[ -f "$AT_WS" ]]; then
    echo "at_ws (zsh)"
    source "$AT_WS"
fi
