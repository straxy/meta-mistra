#!/bin/sh

PATH=/sbin:/bin:/usr/sbin:/usr/bin

mkdir -p /proc /sys /tmp
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t tmpfs tmpfs /tmp

# use /dev with devtmpfs
if grep -q devtmpfs /proc/filesystems; then
  mkdir -p /dev
  mount -t devtmpfs devtmpfs /dev
else
  if [ ! -d /dev ]; then
    fatal "ERROR: /dev doesn't exist and kernel doesn't has devtmpfs enabled."
  fi
fi

exec sh
