#!/bin/bash

set -e

mkdir -p src
vcs import --input deps.repos src
rm -rf src/navigation2/nav2_system_tests

source ../ros2_setup.sh

rosdep install \
    --reinstall \
    --from-paths src \
    --ignore-src \
    -s | awk '{print $5}' | sed -E '/^\s*$/d' | sort -n > rosdep.txt
