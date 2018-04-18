#!/bin/bash

# Install the VMWare Tools from a linux ISO.

if [ "${PACKER_BUILDER_TYPE}" == "vmware-iso" ]; then
  curl -sSL -o /var/tmp/vmware-tools-repo-ubuntu12.04.deb https://packages.vmware.com/tools/esx/6.5/repos/vmware-tools-repo-ubuntu12.04_10.1.0-1.precise_amd64.deb
  dpkg -i /var/tmp/vmware-tools-repo-ubuntu12.04.deb
  rm /var/tmp/vmware-tools-repo-ubuntu12.04.deb
  export DEBIAN_FRONTEND=noninteractive

  # Replace http with https to avoid redirect.
  sed -i -e 's/http:/https:/g' /etc/apt/sources.list.d/vmware-osps.list
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C0B5E0AB66FD4949

  # Add vmware cert temporarily.
  cp /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt.vmware
  echo $(echo -n | openssl s_client -showcerts -connect packages.vmware.com:443 2>/dev/null  | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p') >> /etc/ssl/certs/ca-certificates.crt

  # Update only new repo.
  apt-get update -o Dir::Etc::sourcelist="sources.list.d/vmware-osps.list" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
  apt-get install -y vmware-tools-core vmware-tools-esx

  # Clean up the repo.
  apt-get remove -y vmware-tools-repo-ubuntu12.04
  rm /etc/apt/sources.list.d/vmware-osps.list

  # Put certs back.
  mv /etc/ssl/certs/ca-certificates.crt.vmware /etc/ssl/certs/ca-certificates.crt
fi
