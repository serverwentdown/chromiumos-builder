#!/bin/sh

set -e

echo "Entering /chromiumos working directory"
cd /chromiumos

echo "Syncing source"
repo init -u https://chromium.googlesource.com/chromiumos/manifest.git --repo-url https://chromium.googlesource.com/external/repo.git
repo sync -j6

