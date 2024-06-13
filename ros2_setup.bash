ROS2_WS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "ros2_ws: $ROS2_WS"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.bash"
if [[ -f "$ROS2_SETUP" ]]; then
    # export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_humble (bash)"
    source "$ROS2_SETUP"
fi

TURTLEBOT4_DESKTOP_WS="$ROS2_WS/turtlebot4_desktop"
if [[ -f "$TURTLEBOT4_DESKTOP_WS/install/local_setup.bash" ]]; then
    echo "turtlebot4_desktop (bash)"
    source "$TURTLEBOT4_DESKTOP_WS/install/local_setup.bash"
fi

TURTLEBOT4_ROBOT_WS="$ROS2_WS/turtlebot4_robot"
if [[ -f "$TURTLEBOT4_ROBOT_WS/install/local_setup.bash" ]]; then
    echo "turtlebot4_robot (bash)"
    source "$TURTLEBOT4_ROBOT_WS/install/local_setup.bash"
fi

ROBOT_SETUP="/etc/turtlebot4/setup.bash"
if [ -f "$ROBOT_SETUP" ]; then
    echo "turtlebot4_setup (bash)"
    export ROBOT_SETUP
    # source "$ROBOT_SETUP"
    source "/etc/turtlebot4/aliases.bash"
fi

AT_WS="$ROS2_WS/../AutoTrace/at_ws/install/local_setup.bash"
if [[ -f "$AT_WS" ]]; then
    echo "at_ws (bash)"
    source "$AT_WS"
fi
