#!/usr/bin/bash

set -e
set -o pipefail
# set -u
# set -x

umask 0022

################################################################################

. ./0-script-lib.sh

init_mixin

get_moveit2_src

for patch in patches/*.patch; do
  repo=$(basename "$patch" .patch)
  echo "Applying patch: $patch to src/$repo"
  git -C "src/$repo" apply "../../$patch"
done

# git -C "src/geometric_shapes" apply ../../patches/geometric_shapes.patch
# git -C "src/moveit2" apply ../../patches/moveit2.patch
# git -C "src/moveit2_tutorials" apply ../../patches/moveit2_tutorials.patch
# git -C "src/moveit_task_constructor" apply ../../patches/moveit_task_constructor.patch
# git -C "src/moveit_visual_tools" apply ../../patches/moveit_visual_tools.patch

update_moveit2_dep_pkgs
