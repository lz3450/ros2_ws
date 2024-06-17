#!/bin/bash

set -e

mkdir -p src
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src

sudo rosdep init || :
rosdep update

rosdep install \
    --reinstall \
    --from-paths src \
    --ignore-src \
    --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers" \
    -s \
    | awk '{print $5}' | sed -E '/^\s*$/d' | sort -n > rosdep.txt

sed -e '/^clang-format$/d' \
    -e '/^clang-tidy$/d' \
    -e '/^cmake$/d' \
    -e '/^curl$/d' \
    -e '/^file$/d' \
    -e '/^git$/d' \
    -e '/^openssl$/d' \
    -e '/^pkg-config$/d' \
    -i rosdep.txt
