#!/bin/bash

set -e

DEPS=(
    libacl1-dev
    libasio-dev
    libassimp-dev
    libcurl4-openssl-dev
    libeigen3-dev
    libfreetype6-dev
    liborocos-kdl-dev
    libtinyxml2-dev
    libx11-dev
    libxaw7-dev
    libxrandr-dev
    python3-lark
    python3-numpy
    python3-python-qt-binding
    qtbase5-dev
    rti-connext-dds-6.0.1
    libgl1-mesa-dev
    libopencv-dev
    libbullet-dev
)

sudo apt-get install -y "${DEPS[@]}"

# rosdep install --from-paths src --ignore-src --rosdistro=humble --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers" -s
