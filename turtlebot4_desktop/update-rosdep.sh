#!/bin/bash

set -e

mkdir -p src
vcs import --input deps.repos src
xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}

source ../ros2_setup.sh

rosdep install \
    --reinstall \
    --from-paths src \
    --ignore-src \
    -s | awk '{print $5}' | sed -E '/^\s*$/d' | sort -n > rosdep.txt
