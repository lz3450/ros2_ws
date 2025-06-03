#!/usr/bin/bash

. /etc/os-release
. ../ros2_setup.sh

MOVEIT2_DEP_PKGS_FILE="moveit2-dep-pkgs-$UBUNTU_CODENAME.txt"
MOVEIT2_DEP_PKGS_TO_INSTALL_FILE="moveit2-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

init_mixin() {
    if [[ ! -d "$HOME/.colcon/mixin/default/" ]]; then
        colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
    fi
    colcon mixin update default
}

get_moveit2_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
    fi
    vcs import --force --recursive --input deps.repos src
    vcs import --force --recursive --input src/moveit2_tutorials/moveit2_tutorials.repos src
    vcs import --force --recursive --input src/moveit2/moveit2.repos src
}

update_moveit2_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        --skip-keys="urdfdom urdfdom_headers" \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "s/'$//g" | LC_ALL=C sort -n > "$MOVEIT2_DEP_PKGS_FILE"

    sed -i \
        -e '/^.*clang.*$/d' \
        -e '/^cmake$/d' \
        -e '/^cppcheck$/d' \
        -e '/^doxygen$/d' \
        -e '/^git$/d' \
        -e '/^iwyu$/d' \
        -e '/^jupyter-notebook$/d' \
        -e '/^libboost-/ {/libboost-all-dev/!d}' \
        -e '/^pkg-config$/d' \
        -e "s/'$//g" \
        "$MOVEIT2_DEP_PKGS_FILE"
}

install_moveit2_dep_pkgs() {
    grep -v 'ros-' "$MOVEIT2_DEP_PKGS_FILE" | xargs sudo apt-get install -s \
        | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n \
        > "$MOVEIT2_DEP_PKGS_TO_INSTALL_FILE"

    if [[ -s "$MOVEIT2_DEP_PKGS_FILE" ]]; then
        grep -v 'ros-' "$MOVEIT2_DEP_PKGS_FILE" | xargs sudo apt-get install -y
    fi
}
