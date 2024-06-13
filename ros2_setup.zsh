ROS2_WS="$(cd "$(dirname "${(%):-%N}")" && pwd)"
echo "ros2_ws: $ROS2_WS"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.zsh"
if [[ -f "$ROS2_SETUP" ]]; then
    # export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_humble (zsh)"
    source "$ROS2_SETUP"
fi

TURTLEBOT4_ROBOT_WS="$ROS2_WS/turtlebot4_robot"
if [[ -f "$TURTLEBOT4_ROBOT_WS/install/local_setup.zsh" ]]; then
    echo "turtlebot4_robot (zsh)"
    source "$TURTLEBOT4_ROBOT_WS/install/local_setup.zsh"
fi

AT_WS="$ROS2_WS/../AutoTrace/at_ws/install/local_setup.zsh"
if [[ -f "$AT_WS" ]]; then
    echo "at_ws (zsh)"
    source "$AT_WS"
fi
