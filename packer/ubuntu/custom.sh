#!/bin/bash
#

# Install packages
export DEBIAN_FRONTEND=noninteractive
PACKAGES="curl open-vm-tools"
apt-get install -y -q --no-install-recommends ${PACKAGES}
