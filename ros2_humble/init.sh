#!/bin/bash

set -e

if [[ ! -d "src" ]]; then
    mkdir -p src
    vcs import --force --shallow --recursive --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src
    if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
        xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
    fi
fi

xargs -a rosdep.txt sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | sort -n > rosdep-pkgs.txt
xargs -a rosdep.txt sudo apt-get install -y
