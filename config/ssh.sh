#!/bin/sh

uci set firewall.Allow_SSH_Inbound='rule'
uci set firewall.Allow_SSH_Inbound.target='ACCEPT'
uci set firewall.Allow_SSH_Inbound.src='lan'
uci set firewall.Allow_SSH_Inbound.proto='tcp'
uci set firewall.Allow_SSH_Inbound.dest_port='22'

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
