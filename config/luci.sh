#!/bin/sh

opkg install luci-ssl

/etc/init.d/uhttpd start
/etc/init.d/uhttpd enable
