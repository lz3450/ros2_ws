#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

tar --zstd -vcf xarm_lite6_backup.tar.zst build install src log
