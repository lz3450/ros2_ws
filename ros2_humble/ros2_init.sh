#!/bin/bash

# https://docs.ros.org/en/humble/Installation/Alternatives/Ubuntu-Development-Setup.html

set -e

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-utils curl

sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt-get update
sudo apt-get install -s \
    python3-pip \
    ros-dev-tools \
    | grep "^Inst" | awk '{print $2}' | sort -n > init-pkgs.txt
sudo apt-get install -y \
    python3-pip \
    ros-dev-tools

sudo rosdep init || :
rosdep update
