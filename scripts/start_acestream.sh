#!/bin/sh
PATH=/sbin:/usr/sbin:/bin:/usr/bin

ACEADDON=$(cd $(dirname "$0") && pwd)
ACECHROOT="androidfs"
PERMISSION=""
SYSNSPAWN=""
 
if [ $(id -u) != 0 ]; then
  PERMISSION=$(which sudo)
  if [ -x "$PERMISSION" ]; then
    echo "Without sudo and not a root. Exiting."
    exit 1
  fi
fi

if [ ! -d "$ACEADDON/$ACECHROOT" ]; then
  echo "Core acestream application is not found. Exiting."
  exit 1
fi

SYSNSPAWN=$(which systemd-nspawn)
if [ -z "$SYSNSPAWN" ]; then
  echo "Your system does not have systemd-nspawn binary. Exiting."
  exit 1
fi

if [ ! -x "$ACEADDON/$ACECHROOT/system/bin/sh" ]; then
  echo "Some files are not executable (/bin/sh). Exiting"
  exit 1
fi

if [ ! -x "$ACEADDON/$ACECHROOT/system/data/data/org.acestream.engine/files/python/bin/python" ]; then
  echo "Some files is not executable (/bin/python). Exiting"
  exit 1
fi

ln -s /usr/share/zoneinfo/ $ACEADDON/$ACECHROOT/usr/share/zoneinfo
 
$PERMISSION $SYSNSPAWN --register=no -D $ACEADDON/$ACECHROOT \
  --chdir=/system/data/data/org.acestream.engine/files/ \
  /system/bin/sh /system/bin/acestream.sh \
  --log-debug 0 --check-live-pos-interval 5 --core-skip-have-before-playback-pos 1 \
  --webrtc-allow-outgoing-connections 1 > $ACEADDON/acestream.log