#!/usr/bin/bash

. /etc/os-release
. ../ros2_setup.sh

MOVEIT2_DEP_PKGS_FILE="moveit2-dep-pkgs-$UBUNTU_CODENAME.txt"
MOVEIT2_DEP_PKGS_TO_INSTALL_FILE="moveit2-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

get_moveit2_src() {
    if [[ ! -d "src" ]]; then
        mkdir -p src
        git clone -b $ROS_DISTRO --depth 1 https://github.com/moveit/moveit2.git src/moveit2
        vcs import --force --shallow --recursive --input src/moveit2/moveit2.repos src
        vcs import --force --shallow --recursive --input deps.repos src
        if [[ -f "unnecessary_ros2_pkgs.txt" ]]; then
            xargs -a unnecessary_ros2_pkgs.txt -I {} rm -rf src/{}
        fi
    fi
}

update_moveit2_dep_pkgs() {
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        -s | awk '{print $5}' | sed -E '/^\s*$/d' | LC_ALL=C sort -n > "$MOVEIT2_DEP_PKGS_FILE"

    sed -i \
        -e '/^clang.*$/d' \
        -e '/^cmake$/d' \
        -e '/^doxygen$/d' \
        -e '/^git$/d' \
        -e '/^pkg-config$/d' \
        -e "s/'$//g" \
        "$MOVEIT2_DEP_PKGS_FILE"
}

install_moveit2_dep_pkgs() {
    grep -v 'ros-' "$MOVEIT2_DEP_PKGS_FILE" | xargs sudo apt-get install -s \
        | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n \
        > "$MOVEIT2_DEP_PKGS_TO_INSTALL_FILE"
    grep -v 'ros-' "$MOVEIT2_DEP_PKGS_FILE" | xargs sudo apt-get install -y
}
