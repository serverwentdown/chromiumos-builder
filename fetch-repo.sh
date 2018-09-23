#!/bin/sh

set -e

apk add --no-cache git

# See http://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html#_setting_up
echo "Getting depot_tools"
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /sdk/opt/depot_tools
rm -rf /sdk/opt/depot_tools/.git

