ROS2_WS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "ros2_ws: $ROS2_WS"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.bash"
if [[ -f "$ROS2_SETUP" ]]; then
    # export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_humble (bash)"
    source "$ROS2_SETUP"
fi

TURTLEBOT4_ROBOT_WS="/home/kzl/Projects/turtlebot4_robot"
if [[ -f "$TURTLEBOT4_ROBOT_WS/install/local_setup.bash" ]]; then
    echo "turtlebot4_robot (bash)"
    source "$TURTLEBOT4_ROBOT_WS/install/local_setup.bash"
fi

AT_WS="/home/kzl/Projects/AutoTrace/at_ws/install/local_setup.bash"
if [[ -f "$AT_WS" ]]; then
    echo "at_ws (bash)"
    source "$AT_WS"
fi
