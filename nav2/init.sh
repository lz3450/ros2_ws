#!/bin/bash

ubuntu_codename=$(. /etc/os-release && echo $UBUNTU_CODENAME)

set -e

### For "nav2_system_tests"
# sudo bash -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
# curl http://packages.osrfoundation.org/gazebo.key | gpg --dearmor | sudo install -o root -g root -m 644 /dev/stdin /etc/apt/trusted.gpg.d/gazebo.gpg

sudo apt-get update
sudo apt-get upgrade -y

if [[ ! -d "src" ]]; then
    mkdir -p src
    vcs import --force --shallow --recursive --input deps.repos src
    if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
        xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
    fi
fi

grep -v 'ros-' rosdep-$ubuntu_codename.txt | xargs sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n > rosdep-installed-pkgs-$ubuntu_codename.txt
grep -v 'ros-' rosdep-$ubuntu_codename.txt | xargs sudo apt-get install -y
