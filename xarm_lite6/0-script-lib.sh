#!/bin/bash
#
# 0-script-lib.sh
#

. /etc/os-release
. ../moveit2_setup.sh

XARM_LITE6_DEP_PKGS_FILE="xarm-lite6-dep-pkgs-$UBUNTU_CODENAME.txt"
XARM_LITE6_DEP_PKGS_TO_INSTALL_FILE="xarm-lite6-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

get_xarm_lite6_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --recursive --input deps.repos src
}

update_xarm_lite6_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        --skip-keys="backward_ros" \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "s/'$//g" | LC_ALL=C sort -n > "$XARM_LITE6_DEP_PKGS_FILE"

    sed -i \
        -e '/^cmake$/d' \
        -e '/^libboost-/ {/libboost-all-dev/!d}' \
        -e '/^pkg-config$/d' \
        "$XARM_LITE6_DEP_PKGS_FILE"
}

install_xarm_lite6_dep_pkgs() {
    grep -v 'ros-' "$XARM_LITE6_DEP_PKGS_FILE" | xargs sudo apt-get install -s \
        | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n \
        > "$XARM_LITE6_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$XARM_LITE6_DEP_PKGS_FILE" ]]; then
        grep -v 'ros-' "$XARM_LITE6_DEP_PKGS_FILE" | xargs sudo apt-get install -y
    fi
}
