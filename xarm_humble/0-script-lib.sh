#!/bin/bash
#
# 0-script-lib.sh
#

. /etc/os-release
. ../ros2_setup.sh
. ../moveit2_setup.sh

XARM_DEP_PKGS_FILE="xarm-dep-pkgs-$UBUNTU_CODENAME.txt"
XARM_DEP_PKGS_TO_INSTALL_FILE="xarm-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

get_xarm_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --recursive --input deps.repos src
}

update_xarm_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        --skip-keys="backward_ros" \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "s/'$//g" | LC_ALL=C sort -n > "$XARM_DEP_PKGS_FILE"

    sed -i \
        -e '/^cmake$/d' \
        -e '/^libboost-/ {/libboost-all-dev/!d}' \
        -e '/^pkg-config$/d' \
        "$XARM_DEP_PKGS_FILE"
}

install_xarm_dep_pkgs() {
    grep -v 'ros-' "$XARM_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -s \
        | (grep "^Inst" || :) | awk '{print $2}' | LC_ALL=C sort -n \
        > "$XARM_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$XARM_DEP_PKGS_FILE" ]]; then
        grep -v 'ros-' "$XARM_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -y
    fi
}
