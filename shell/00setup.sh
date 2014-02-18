#!/bin/sh

## dpkg and apt

SOURCES_LIST="/etc/apt/sources.list"
# use official repository (for squid-deb-proxy)
sed -i 's/mirrors.kernel.org/cdn.debian.net/g' $SOURCES_LIST
# enable contrib and non-free
sed -i 's/wheezy main$/wheezy main contrib non-free/g' $SOURCES_LIST
# avoid interruption
export DEBIAN_FRONTEND=noninteractive

## chef

apt-get -qq update
apt-get --no-install-recommends -qq -y install chef
