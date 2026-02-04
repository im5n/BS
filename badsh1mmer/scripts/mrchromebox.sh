#!/bin/bash

get_internal() {
  # get_largest_cros_blockdev does not work in BadApple.
  local ROOTDEV_LIST=$(cgpt find -t rootfs) # thanks stella
  if [ -z "$ROOTDEV_LIST" ]; then
    fail "could not parse for rootdev devices. this should not have happened."
  fi
  local device_type=$(echo "$ROOTDEV_LIST" | grep -oE 'blk0|blk1||nvme|sda' | head -n 1)
  case $device_type in
  "blk0")
    intdis=/dev/mmcblk0
      intdis_prefix="p"
    break
    ;;
  "blk1")
    intdis=/dev/mmcblk1
      intdis_prefix="p"
    break
    ;;
  "nvme")
    intdis=/dev/nvme0
      intdis_prefix="n"
    break
    ;;
  "sda")
    intdis=/dev/sda
      intdis_prefix=""
    break
    ;;
  *)
    fail "an unknown error occured. this should not have happened."
    ;;
  esac
}

if [ -f /usb/usr/sbin/scripts/mrchromebox.tar.gz ]; then
	echo "extracting mrchromebox.tar.gz"
	mkdir -p /mrchromebox
	tar -xf /usb/usr/sbin/scripts/mrchromebox.tar.gz -C /mrchromebox
else
	echo "mrchromebox.tar.gz not found!" >&2
	exit 1
fi

clear
chmod +x /mrchromebox/firmware-util.sh
mkdir /localroot
get_internal
mount "$intdis$intdis_prefix"3 /localroot -o ro # TODO: add int disk determination
mount --bind /dev /localroot/dev
mount --bind /sys /localroot/sys
mount --bind /mrchromebox /localroot/mnt/stateful_partition # use stateful because it is always clean
chroot /localroot /mnt/stateful_partition/firmware-util.sh
echo "cleaning up..."
rm -rf /mrchromebox
umount /localroot/dev
umount /localroot/mnt/stateful_partition
umount /localroot
rmdir /localroot
