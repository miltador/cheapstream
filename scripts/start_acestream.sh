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
 
$PERMISSION $SYSNSPAWN $ACEADDON/$ACECHROOT /system/bin/sh -c \
  "cd /system/data/data/org.acestream.engine/files ; /system/bin/acestream.sh" > $ACEADDON/acestream.log