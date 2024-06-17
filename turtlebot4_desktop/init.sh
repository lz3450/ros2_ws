#!/bin/bash

set -e

sudo apt-get update
sudo apt-get upgrade -y

mkdir -p src
vcs import --input deps.repos src

source ../ros2_setup.sh

# rosdep install \
#     --reinstall \
#     --from-paths src \
#     --ignore-src \
#     -s | awk '{print $5}' | sed -E '/^\s*$/d' | sort -n > rosdep.txt
grep -v 'ros-' rosdep.txt | xargs sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | sort -n > rosdep-pkgs.txt
grep -v 'ros-' rosdep.txt | xargs sudo apt-get install -y
