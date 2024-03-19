#!/bin/bash

# https://docs.ros.org/en/humble/Installation/Alternatives/Ubuntu-Development-Setup.html

set -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update

sudo apt install -y \
    python3-pip \
    ros-dev-tools

mkdir -p src
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src

sudo rosdep init || :
rosdep update

sudo apt install -y \
    libacl1-dev \
    libasio-dev \
    libtinyxml2-dev \
    libx11-dev \
    libxaw7-dev \
    libeigen3-dev \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libgl-dev \
    libxrandr-dev \
    libbullet-dev \
    libopencv-dev \
    python3-lark \
    python3-numpy \
    qtbase5-dev \
    python3-python-qt-binding \
    libshiboken2-dev \
    libpyside2-py3-5.15

# rosdep install --from-paths src --ignore-src --rosdistro=humble --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers" -s
