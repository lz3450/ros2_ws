#!/usr/bin/bash
#
# ros2/lib.sh
#

if [[ -z "$ROS_DISTRO" ]]; then
    echo "ROS_DISTRO is not set"
    exit 1
fi

. /etc/os-release

ROS2_DEV_TOOLS_DEP_PKGS_FILE="ros2-dev-tools-dep-pkgs-$UBUNTU_CODENAME.txt"
ROS2_DEP_PKGS_FILE="ros2-dep-pkgs-$UBUNTU_CODENAME.txt"
ROS2_DEP_PKGS_TO_INSTALL_FILE="ros2-dep-pkgs-to-install-$UBUNTU_CODENAME.txt"

ros2_repo_setup() {
    ### ROS2 building environment setup
    # https://docs.ros.org/en/$ROS_DISTRO/Installation/Alternatives/Ubuntu-Development-Setup.html
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ros2.list
}

update_ros2_dev_tools_dep_pkgs() {
    sudo apt-get update
    sudo apt-get install -s \
        python3-pip \
        ros-dev-tools \
        | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n \
        > "$ROS2_DEV_TOOLS_DEP_PKGS_FILE"
}

install_ros2_dev_tools_dep_pkgs() {
    sudo apt-get update
    sudo apt-get install -y \
        python3-pip \
        ros-dev-tools
}

get_ros2_src() {
    local _repos="https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos"
    if [[ -n "$1" ]]; then
        _repos="$1"
    fi

    if [[ -d "src" ]]; then
        return
    fi
    mkdir -p src
    vcs import --force --shallow --recursive --input "$_repos" src
}

update_ros2_dep_pkgs() {
    if [[ ! -f "/etc/ros/rosdep/sources.list.d/20-default.list" ]]; then
        sudo -E rosdep init
    fi
    rosdep update --rosdistro=$ROS_DISTRO
    rosdep install \
        --rosdistro=$ROS_DISTRO \
        --reinstall \
        --from-paths src \
        --ignore-src \
        --skip-keys="fastcdr rti-connext-dds-6.0.1 urdfdom_headers" \
        -s | awk '{print $5}' | sed -E -e '/^\s*$/d' -e "/'$/s/'//" | LC_ALL=C sort -n > "$ROS2_DEP_PKGS_FILE"

    sed -i \
        -e '/^clang-format$/d' \
        -e '/^clang-tidy$/d' \
        -e '/^cmake$/d' \
        -e '/^cppcheck$/d' \
        -e '/^curl$/d' \
        -e '/^doxygen$/d' \
        -e '/^file$/d' \
        -e '/^git$/d' \
        -e '/^openssl$/d' \
        -e '/^pkg-config$/d' \
        -e "s/'$//g" \
        "$ROS2_DEP_PKGS_FILE"
}

install_ros2_dep_pkgs() {
    xargs -a "$ROS2_DEP_PKGS_FILE" sudo apt-get install -s \
        | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n \
        > "$ROS2_DEP_PKGS_TO_INSTALL_FILE"
    xargs -a "$ROS2_DEP_PKGS_TO_INSTALL_FILE" sudo apt-get install -y
}

################################################################################

install_ros2_dev_tools_custom() {
    ### ROS2 building environment setup (customized)
    local -a _pip_pkgs=(
        colcon-argcomplete
        colcon-bash
        colcon-cd
        colcon-cmake
        colcon-common-extensions
        colcon-core
        colcon-defaults
        colcon-devtools
        colcon-installed-package-information
        colcon-library-path
        colcon-metadata
        colcon-mixin
        colcon-notification
        colcon-output
        colcon-override-check
        colcon-package-information
        colcon-package-selection
        colcon-parallel-executor
        colcon-pkg-config
        colcon-powershell
        colcon-python-setup-py
        colcon-recursive-crawl
        colcon-ros
        colcon-test-result
        colcon-zsh
        pytest-mock
        pytest-runner
        pytest-timeout
        rosdep
        vcstool
    )
    python3 -m pip wheel --wheel-dir ~/wheels --no-binary :all: "${_pip_pkgs[@]}"
    python3 -m pip install --user -U --no-index --find-links ~/wheels "${_pip_pkgs[@]}"
}

install_ros2_dep_pkgs_custom() {
    ### ROS2 dependencies installation (customized)
    local -a _deb_pkgs=(
        cmake
        libasio-dev
        libgl1-mesa-dev
        libglx-dev
        liblttng-ctl-dev
        liblttng-ust-dev
        libopencv-dev
        libopengl-dev
        liborocos-kdl-dev
        libtinyxml2-dev
        qtbase5-dev
        libogre-1.12-dev
    )
    sudo apt-get install -s "${_deb_pkgs[@]}" | grep "^Inst" | awk '{print $2}' | LC_ALL=C sort -n > customized-$ROS_DISTRO-pkgs-to-install-$UBUNTU_CODENAME.txt
    sudo apt-get install -y "${_deb_pkgs[@]}"
    local -a _pip_pkgs=(
        pybind11
    )
    python3 -m pip wheel --wheel-dir ~/wheels --no-binary :all: "${_pip_pkgs[@]}"
    python3 -m pip install --user -U --no-index --find-links ~/wheels "${_pip_pkgs[@]}"
}
