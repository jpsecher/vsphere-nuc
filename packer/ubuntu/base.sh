#!/bin/bash

# Use DK mirrors.
sudo sed -i \
-e 's/\/us.archive.ubuntu.com/\/dk.archive.ubuntu.com/' \
-e 's/\/archive.ubuntu.com/\/dk.archive.ubuntu.com/' \
/etc/apt/sources.list

# Completely clean package lists.
apt-get clean
rm -fr /var/lib/apt/lists
mkdir -p /var/lib/apt/lists/partial
apt-get clean
apt-get update

export DEBIAN_FRONTEND=noninteractive
apt-get -y install linux-headers-$(uname -r) build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev curl unzip

# Speed up SSHd.
echo 'UseDNS no' | tee -a /etc/ssh/sshd_config
