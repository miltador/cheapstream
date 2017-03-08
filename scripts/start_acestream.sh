#!/bin/sh
PATH=/sbin:/usr/sbin:/bin:/usr/bin

ACEADDON=$(cd $(dirname "$0") && pwd)
ACECHROOT="androidfs"
PERMISSION=""
SYSNSPAWN=""

if [ $(id -u) != 0 ]; then
  PERMISSION=$(which sudo)
  if [ ! -x "$PERMISSION" ]; then
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

if [ ! -x "$ACEADDON/$ACECHROOT/data/data/org.acestream.media/files/python/bin/python" ]; then
  echo "Some files is not executable (/bin/python). Exiting"
  exit 1
fi

ACE_ARG="--client-console"

if [ -f $ACEADDON/acestream-user.conf ]; then
  . $ACEADDON/acestream-user.conf
  if [ -n "$ACE_USER_ARG" ]; then
    ACE_ARG="$ACE_ARG $ACE_USER_ARG"
  fi
fi

$PERMISSION $SYSNSPAWN --register=no \
  -D $ACEADDON/$ACECHROOT \
  /system/bin/sh /system/bin/acestream.sh $ACE_ARG > $ACEADDON/acestream.log 2>&1
