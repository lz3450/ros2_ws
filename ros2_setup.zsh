ROS2_WS="/home/kzl/Projects/ros2_ws"

ROS2_SETUP="$ROS2_WS/ros2_humble/install/local_setup.zsh"
if [[ -f "$ROS2_SETUP" ]]; then
    # export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
    echo "ros2_humble (zsh)"
    source "$ROS2_SETUP"
fi
