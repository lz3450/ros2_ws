#!/usr/bin/env bash
#
# tb4-init.sh
#

set -e

if [ $EUID -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

SRCDIR="../../src/tb4"

# chrony
mkdir -p /etc/chrony
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/chrony.conf /etc/chrony/

# netplan
# mkdir -p /etc/netplan
cp -v "$SRCDIR"/turtlebot4_setup/etc/netplan/40-ethernets.yaml /etc/netplan/
cp -v "$SRCDIR"/turtlebot4_setup/etc/netplan/50-wifis.yaml /etc/netplan/

mkdir -p /etc/turtlebot4
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/cyclonedds_rpi.xml /etc/turtlebot4/
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/discovery.conf /etc/turtlebot4/
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/discovery.sh /etc/turtlebot4/
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/fastdds_discovery_create3.xml /etc/turtlebot4/
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/fastdds_rpi.xml /etc/turtlebot4/
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/setup.bash /etc/turtlebot4/
cp -v "$SRCDIR"/turtlebot4_setup/etc/turtlebot4/system /etc/turtlebot4/
sed -i \
    -e '/MODEL:/s/standard/lite/' \
    /etc/turtlebot4/system
sed -i \
    -e '/^export WORKSPACE_SETUP=/s|=.*|=/home/tb4/setup.sh|' \
    /etc/turtlebot4/setup.bash

mkdir -p /etc/udev
cp -v "$SRCDIR"/turtlebot4_setup/udev/50-turtlebot4.rules /etc/udev/rules.d/
cp -v "$SRCDIR"/turtlebot4_setup/udev/80-movidius.rules /etc/udev/rules.d/
cp -v "$SRCDIR"/turtlebot4_setup/udev/99-gpio.rules /etc/udev/rules.d/

sed -i \
    -e 's/$/ dwc_otg.lpm_enable=0/' \
    -e 's/$/ fixrtc/' \
    -e 's/$/ modules-load=dwc2,g_ether/' \
    /boot/firmware/cmdline.txt
nano /boot/firmware/cmdline.txt

nano /boot/firmware/config.txt

echo "Successfully initialized TurtleBot4"
