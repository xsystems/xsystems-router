#!/bin/sh

uci add firewall rule
uci set firewall.@rule[-1].name='Allow-SSH-Inbound'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].src='lan'
uci set firewall.@rule[-1].proto='tcp'
uci set firewall.@rule[-1].dest_port='22'

uci commit firewall
/etc/init.d/firewall restart


uci set dropbear.@dropbear[0]='dropbear'
uci set dropbear.@dropbear[0].enable='true'
uci set dropbear.@dropbear[0].Interface='lan'
uci set dropbear.@dropbear[0].Port='22'
uci set dropbear.@dropbear[0].PasswordAuth='false'
uci set dropbear.@dropbear[0].RootLogin='true'
uci set dropbear.@dropbear[0].RootPasswordAuth='false'

uci commit dropbear

/etc/init.d/dropbear reload
