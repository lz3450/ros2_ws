#!/bin/bash

set -e

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# apt-get update
# apt-get upgrade -y

# apt-get install -y chrony
mkdir -p /etc/chrony
cp -v ../src/turtlebot4_setup/etc/chrony/chrony.conf /etc/chrony/

mkdir -p /etc/netplan
cp -v ../src/turtlebot4_setup/etc/netplan/40-ethernets.yaml /etc/netplan/
cp -v ../src/turtlebot4_setup/etc/netplan/50-wifis.yaml /etc/netplan/
chown kzl:kzl /etc/netplan/40-ethernets.yaml /etc/netplan/50-wifis.yaml
chmod 600 /etc/netplan/40-ethernets.yaml /etc/netplan/50-wifis.yaml

mkdir -p /etc/turtlebot4
cp -v ../src/turtlebot4_setup/etc/turtlebot4/cyclonedds_rpi.xml /etc/turtlebot4/
cp -v ../src/turtlebot4_setup/etc/turtlebot4/discovery.conf /etc/turtlebot4/
cp -v ../src/turtlebot4_setup/etc/turtlebot4/discovery.sh /etc/turtlebot4/
cp -v ../src/turtlebot4_setup/etc/turtlebot4/fastdds_discovery_super_client.xml /etc/turtlebot4/
cp -v ../src/turtlebot4_setup/etc/turtlebot4/fastdds_rpi.xml /etc/turtlebot4/
cp -v ../src/turtlebot4_setup/etc/turtlebot4/setup.bash /etc/turtlebot4/
cp -v ../src/turtlebot4_setup/etc/turtlebot4/system /etc/turtlebot4/
sed -i \
    -e '/MODEL:/s/standard/lite/' \
    /etc/turtlebot4/system
sed -i \
    -e '/^export WORKSPACE_SETUP=/s|=.*|=/home/kzl/Projects/ros2_ws/ros2_setup.sh|' \
    /etc/turtlebot4/setup.bash

mkdir -p /etc/udev
cp -v ../src/turtlebot4_setup/udev/50-turtlebot4.rules /etc/udev/rules.d/
cp -v ../src/turtlebot4_setup/udev/80-movidius.rules /etc/udev/rules.d/
cp -v ../src/turtlebot4_setup/udev/99-gpio.rules /etc/udev/rules.d/

sed -i \
    -e 's/\s*fixrtc\s*/ /' \
    -e 's/ *$//' -e 's/^ *//' \
    -e 's/$/ fixrtc/' \
    -e 's/$/ modules-load=dwc2,g_ether/' \
    /boot/firmware/cmdline.txt
nano /boot/firmware/cmdline.txt

# cat >> /boot/firmware/config.txt <<EOF

# [all]
# dtoverlay=dwc2,dr_mode=peripheral
# dtoverlay=i2c-gpio,bus=3,i2c_gpio_delay_us=1,i2c_gpio_sda=4,i2c_gpio_scl=5
# EOF
# nano /boot/firmware/config.txt
