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

# make /boot for mounting boot partition
mkdir -p /boot

# check if SD card is present, if not print to /dev/kmsg
if ! [ -b /dev/mmcblk0 ]; then
  echo "SD card not present!" >/dev/kmsg
  exit 1
fi

# format SD card
sfdisk /dev/mmcblk0 <<EOF
unit: sectors
sector-size: 512

start=    4096, size=  81920, type=c, bootable
start=   86016, size= 681574, type=L
start=  770048, size= 681574, type=L
start= 1454080, size=       , type=L
EOF

mkfs.vfat /dev/mmcblk0p1
#mkfs.ext4 -F -E lazy_itable_init /dev/mmcblk0p2
#mkfs.ext4 -F -E lazy_itable_init /dev/mmcblk0p3
mkfs.ext4 -F -E lazy_itable_init /dev/mmcblk0p4

# mount boot and create u-boot env
mount /dev/mmcblk0p1 /boot
touch /boot/uboot.env

# configure networking
ip addr add 192.168.123.101/24 dev eth0
ip link set eth0 up
ip route add default via 192.168.123.1 dev eth0
tee /etc/resolve.conf <<EOF
nameserver 8.8.8.8
EOF

# start swupdate
/usr/lib/swupdate/swupdate.sh &

exec sh
