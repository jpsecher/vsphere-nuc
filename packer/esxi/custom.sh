#!/bin/bash
#

# Install packages
export DEBIAN_FRONTEND=noninteractive
PACKAGES="curl"
apt-get install -y -q --no-install-recommends ${PACKAGES}
