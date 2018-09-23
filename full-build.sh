#!/bin/sh

set -e

echo "Changing directory"
cd /home/chronos/trunk/src/scripts

echo "Setup board"
export BOARD=amd64-generic
./setup_board --board=${BOARD}

echo "Build packages"
./build_packages --board=${BOARD}

echo "Build image"
./build_image --board=${BOARD} --noenable_rootfs_verification base

