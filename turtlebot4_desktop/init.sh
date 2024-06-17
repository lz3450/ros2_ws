#!/bin/bash

set -e

sudo apt-get update
sudo apt-get upgrade -y

mkdir -p src
vcs import --input deps.repos src
xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}

grep -v 'ros-' rosdep.txt | xargs sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | sort -n > rosdep-pkgs.txt
grep -v 'ros-' rosdep.txt | xargs sudo apt-get install -y
