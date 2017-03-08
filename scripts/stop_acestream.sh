#!/bin/sh
PATH=/sbin:/usr/sbin:/bin:/usr/bin
ACEADDON=$(cd $(dirname "$0") && pwd)
ACECHROOT="androidfs"
PERMISSION=""


if [ $(id -u) != 0 ]; then
        PERMISSION=$(which sudo)
fi

# kill the instance of acestream
$PERMISSION pkill -9 -f "/system/bin/acestream.sh" &>/dev/null
