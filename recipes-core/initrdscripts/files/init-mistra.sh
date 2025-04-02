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
  fatal "SD card not present!"
  exit 1
fi

# format SD card if not already formatted
nr_partitions=$(fdisk -l /dev/mmcblk0 | grep /dev/mmcblk0p | wc -l)
if [ "$nr_partitions" != "4" ]; then
  sfdisk /dev/mmcblk0 <<EOF
unit: sectors
sector-size: 512

start=    4096, size=  81920, type=c, bootable
start=   86016, size= 681574, type=L
start=  770048, size= 681574, type=L
start= 1454080, size=       , type=L
EOF

  mkfs.vfat /dev/mmcblk0p1
  mkfs.ext4 -F -E lazy_itable_init /dev/mmcblk0p4
fi

# mount boot and create u-boot env
mount /dev/mmcblk0p1 /boot
touch /boot/uboot.env

# start swupdate
/usr/lib/swupdate/swupdate.sh &

sleep 5

# mount the USB drive
if [ -b /dev/sda ]; then
  echo "Found USB drive, initiating update" >/dev/kmsg
  mkdir -p /mnt
  mount -t vfat /dev/sda1 /mnt
  swupdate-client /mnt/update-image-cubieboard-ng.rootfs.swu

  # after installation system will reboot
else
  echo "USB drive not found, restarting..." >/dev/kmsg
  reboot -f
fi

exec sh
