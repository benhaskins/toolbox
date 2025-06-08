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

# Based on from https://support.1password.com/install-linux/#debian-or-ubuntu

# fetch 1password keyring
mkdir -p /usr/share/keyrings
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# add list file
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

# add policy file
mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol

# add keyring
mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# update package lists
apt-get update

# install 1password
apt-get install --yes \
    1password \
    1password-cli \

# tidy up again
apt-get clean
apt-get autoremove --yes
