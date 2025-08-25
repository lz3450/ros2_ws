#!/bin/bash

. /etc/os-release
. ../ros2_setup.sh

NAV2_DEP_PKGS_FILE="nav2-dep-pkgs-$UBUNTU_CODENAME.txt"
NAV2_DEP_PKGS_TO_INSTALL_FILE="nav2-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

get_nav2_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --recursive --input deps.repos src
}

update_nav2_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "s/'$//g" | LC_ALL=C sort -n > "$NAV2_DEP_PKGS_FILE"

    sed -i \
        -e '/^.*clang.*$/d' \
        -e '/^cmake$/d' \
        -e '/^cppcheck$/d' \
        -e '/^curl$/d' \
        -e '/^doxygen$/d' \
        -e '/^git$/d' \
        -e '/^iwyu$/d' \
        -e '/^jupyter-notebook$/d' \
        -e '/^libboost-/ {/libboost-all-dev/!d}' \
        -e '/^libcurl/d' \
        -e '/^pkg-config$/d' \
        -e "s/'$//g" \
        "$NAV2_DEP_PKGS_FILE"
}

install_nav2_dep_pkgs() {
    grep -v 'ros-' "$NAV2_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -s \
        | grep "^Inst" || : | awk '{print $2}' | LC_ALL=C sort -n \
        > "$NAV2_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$NAV2_DEP_PKGS_FILE" ]]; then
        grep -v 'ros-' "$NAV2_DEP_PKGS_FILE" | xargs sudo apt-get install --no-install-recommends -y
    fi
}
