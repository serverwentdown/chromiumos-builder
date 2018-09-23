#!/bin/sh

set -e

echo "Entering /chromiumos working directory"
mkdir -p /home/chronos/trunk
cd /home/chronos/trunk

echo "Switching to Python 2"
export EPYTHON=python2

echo "Syncing source"
repo init -u https://chromium.googlesource.com/chromiumos/manifest.git --repo-url https://chromium.googlesource.com/external/repo.git
repo sync -j8

