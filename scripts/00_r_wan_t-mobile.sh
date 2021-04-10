#!/bin/sh

uci set network.@switch_vlan[1].vid='300'
uci set network.@switch_vlan[1].ports='4t 6t'
uci set network.wan.ifname='eth1.300'

uci commit network

/etc/init.d/network reload

printf "%s" "Waiting for WAN connection "
while ! ping -c 1 -w 1 google.com &> /dev/null ; do
    printf "%c" "."
done
printf "%s\n"  " done"
