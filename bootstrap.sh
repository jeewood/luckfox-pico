#!/bin/sh

# Install base
apk update
apk add openrc
rc-update add devfs boot
rc-update add procfs boot
rc-update add sysfs boot
rc-update add networking default
rc-update add local default

# Install TTY
apk add agetty

# Setting up shell
apk add shadow
apk add bash bash-completion
chsh -s /bin/bash
echo -e "j11w00d\nj11w00d" | passwd
apk del -r shadow

# Install SSH
apk add openssh
rc-update add sshd default

# Extra stuff
apk add mtd-utils-ubi
apk add bottom
apk add neofetch
apk add htop
apk add nano
apk add lua
apk add python3
apk add build-base

# Clear apk cache
rm -rf /var/cache/apk/*

# Packaging rootfs
for d in bin etc lib sbin usr; do tar c "$d" | tar x -C /extrootfs; done
for dir in dev proc root run sys var oem userdata; do mkdir /extrootfs/${dir}; done
