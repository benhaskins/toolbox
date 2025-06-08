#!/usr/bin/env bash

if [[ "${EUID}" -ne 0 ]];
then
	echo "This script needs to be run as root"
	echo "usage: sudo ${0}"
	exit 1
fi

source /etc/os-release
if [[ ${ID} != "debian" && ! ${ID_LIKE} =~ "debian" ]]; # debian, ubuntu, mint & lmde will all be like debian
then
    echo "This script is only for Ubuntu/Debian based linux distros"
    exit 1
fi

# Based on https://docs.docker.com/engine/install/ubuntu/

# Add Docker's official GPG key:
apt-get update

# add some dependencies
apt-get install --yes \
    ca-certificates \
    curl

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# update package lists again
apt-get update

# install docker bits
apt-get install --yes \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \

if [[ -n ${SUDO_USER} ]];
then
    usermod -a -G docker ${SUDO_USER}
fi

# tidy up again
apt-get clean --yes
apt-get autoclean --yes
