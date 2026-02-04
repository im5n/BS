#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
SCRIPT_DIR=${SCRIPT_DIR:-"."}

set -eE

SCRIPT_DATE="[2025-08-26]"
SCRIPT_BUILD="1.1.4"
PAYLOAD_DIR=/usb/usr/sbin/scripts
RECOVERY_KEY_LIST="$PAYLOAD_DIR"/short_recovery_keys.txt

MNT=
TMPFILE=

fail() {
	printf "%b\n" "$*" >&2
	exit 1
}

clear
echo "" # fix display
echo "$SCRIPT_DATE" # \n so it displays better
echo "v$SCRIPT_BUILD"
echo ""
echo "(1) Broker / unenrollment up to kernver 5"
echo "(2) Cali / Revert all changes made (reenroll + more)"
echo "(3) Ica / unenrollment up to r129"
echo "(4) MrChromebox Firmware Utility"
echo "(5) Touch .developer_mode (skip 5 minute delay)"
echo "(6) Daub "
echo "(7) QS / Unenrollment up to kernver 6"
echo "(s) Shell"
echo "(c) Credits"
echo "(w) whale payload"
echo "(e) Exit and reboot"
echo ""
echo -n "> "
read choice

if [ "$choice" = "1" ]; then
    /bin/sh "$PAYLOAD_DIR/badbr0ker.sh"
	/bin/sh
 	sleep infinity
elif [ "$choice" = "2" ]; then
    /bin/sh "$PAYLOAD_DIR/caliginosity.sh" # someone fix mrchromebox and icarus if they're broken, I just copy pasted from the sh repo
 	sh /usb/usr/sbin/payloads_menu.sh
  	sleep infinity
elif [ "$choice" = "3" ]; then
    /bin/sh "$PAYLOAD_DIR/icarus.sh"
 	sh /usb/usr/sbin/payloads_menu.sh
  	sleep infinity
elif [ "$choice" = "4" ]; then
    /bin/sh "$PAYLOAD_DIR/mrchromebox.sh"
	sh /usb/usr/sbin/payloads_menu.sh
  	sleep infinity
elif [ "$choice" = "5" ]; then
    /bin/sh "$PAYLOAD_DIR/touchdev.sh"
        sh /usb/usr/sbin/payloads_menu.sh
        sleep infinity
elif [ "$choice" = "6" ]; then
    /bin/sh "$PAYLOAD_DIR/daub.sh"
        sh /usb/usr/sbin/payloads_menu.sh
        sleep infinity
elif [ "$choice" = "badrecovery" ]; then # this is just for debugging.
    /bin/sh "$PAYLOAD_DIR/badrecovery_debug.sh"
        sh /usb/usr/sbin/payloads_menu.sh
        sleep infinity
elif [ "$choice" = "7" ]; then
    /bin/sh "$PAYLOAD_DIR/quicksilver.sh"
        sh /usb/usr/sbin/payloads_menu.sh
        sleep infinity
elif [ "$choice" = "s" ]; then
	/bin/sh #shut up! its fixed now :whale:
	sh /usb/usr/sbin/payloads_menu.sh
    sleep infinity
elif [ "$choice" = "c" ]; then
    echo "-----BadSH1-----"
   	echo "-------------------"
	echo ""
 	echo "entering shell..."
	/bin/sh
 	sleep infinity
elif [ "$choice" = "e" ]; then
    echo "Rebooting in 3 seconds..."
	sleep 3
	reboot -f
 	echo "If you are seeing this the reboot failed, please manually reboot by hitting REFRESH and POWER at the same time."
  	echo "Or you can play around with the shell."
    /bin/sh
 	sleep infinity
elif [ "$choice" = "w" ]; then
	cat "$PAYLOAD_DIR/whale.txt"
 	sleep infinity
else
    echo "Invalid choice"
	echo "entering shell..."
 	echo ""
  	/bin/sh
   	sleep infinity
fi
