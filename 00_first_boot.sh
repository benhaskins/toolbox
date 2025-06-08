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

# This is a script, so stop dpkg asking questions
export DEBIAN_FRONTEND="noninteractive"

# update package lists
apt-get update

# perform system upgrade
apt-get dist-upgrade --yes

# install mandatory core packages
apt-get install --yes \
    curl \
    git \
    htop \
    openssh-server \
    vim \
    wget

# ensure dmidecode available
if [[ -z $(which dmidecode) ]];
then
    apt-get install --yes dmidecode
fi

# install guest additions if running in QEMU
if [[ "QEMU" == $(dmidecode -s system-manufacturer) ]];
then
    apt-get install --yes qemu-guest-agent
fi

# install gnome-session if a desktop env
if dpkg -s "ubuntu-session" >/dev/null 2>&1;
then
    apt-get install --yes gnome-session
fi

# tidy up
apt-get autoremove --yes
apt-get clean --yes
apt-get autoclean --yes
