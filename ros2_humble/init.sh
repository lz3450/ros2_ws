#!/bin/bash

ubuntu_codename=$(. /etc/os-release && echo $UBUNTU_CODENAME)

set -e

if [[ ! -d "src" ]]; then
    mkdir -p src
    vcs import --force --shallow --recursive --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src
    if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
        xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
    fi
fi

xargs -a rosdep-$ubuntu_codename.txt sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n > rosdep-installed-pkgs-$ubuntu_codename.txt
xargs -a rosdep-$ubuntu_codename.txt sudo apt-get install -y
