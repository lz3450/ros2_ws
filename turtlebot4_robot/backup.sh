#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

tar --zstd -vcf tb4_robot_backup.tar.zst build install src log
