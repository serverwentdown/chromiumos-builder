#!/bin/sh

set -e

# See https://www.chromium.org/chromium-os/developer-guide/using-sdk-standalone#TOC-Getting-the-SDK

echo "Getting the SDK"
eval $(wget -O - "https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/chromeos/binhost/host/sdk_version.conf?format=TEXT" | base64 -d | grep '^SDK_LATEST_VERSION=')
wget -O /sdk.tar.xz "https://commondatastorage.googleapis.com/chromiumos-sdk/cros-sdk-${SDK_LATEST_VERSION}.tar.xz"

echo "Extracting the SDK"
mkdir /sdk
cd /sdk
tar xvf /sdk.tar.xz
