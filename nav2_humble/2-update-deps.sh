#!/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

update_nav2_dep_pkgs
