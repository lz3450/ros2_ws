#!/bin/bash

set -e

# sudo apt-get update
# sudo apt-get upgrade -y

mkdir -p src
vcs import --input deps.repos src

source ../ros2_setup.bash

rosdep install --from-paths src --ignore-src -s | sed '1d' | awk '{print $5}' | sort -n > rosdep.txt
grep -v 'ros-' rosdep.txt | xargs sudo apt-get install -s | grep "^Inst" | awk '{print $2}' | sort -n > rosdep-pkgs.txt
grep -v 'ros-' rosdep.txt | xargs sudo apt-get install -y