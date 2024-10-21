#!/bin/sh -e

WLAN_INTERF='wlan0'

WLAN=`/sbin/ifconfig ${WLAN_INTERF} | grep inet\ addr | wc -l`

if [ "$wlan" = "0" ]; then
    /sbin/ifdown ${WLAN_INTERF} && /sbin/ifup ${WLAN_INTERF}
else
    echo "Interface ${WLAN_INTERF} is up"
fi
