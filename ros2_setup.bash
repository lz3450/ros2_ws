ROS2_WS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.bash"
if [[ -f "$ROS2_SETUP" ]]; then
    # export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_humble (bash)"
    source "$ROS2_SETUP"
fi

AT_WS="/home/kzl/Projects/AutoTrace/at_ws/install/local_setup.bash"
if [[ -f "$AT_WS" ]]; then
    echo "at_ws (bash)"
    source "$AT_WS"
fi
