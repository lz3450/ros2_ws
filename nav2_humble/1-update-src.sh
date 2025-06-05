#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

get_nav2_src

rm -rf src/navigation2/nav2_system_tests
