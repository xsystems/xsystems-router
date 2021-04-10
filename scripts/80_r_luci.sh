#!/bin/sh

opkg install luci-ssl luci-app-advanced-reboot

/etc/init.d/uhttpd start
/etc/init.d/uhttpd enable
