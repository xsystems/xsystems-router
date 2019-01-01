#!/bin/sh

uci set firewall.ssh_inbound_allow='rule'
uci set firewall.ssh_inbound_allow.name='ssh_inbound_allow'
uci set firewall.ssh_inbound_allow.target='ACCEPT'
uci set firewall.ssh_inbound_allow.src='lan'
uci set firewall.ssh_inbound_allow.proto='tcp'
uci set firewall.ssh_inbound_allow.dest_port='22'

uci commit firewall
/etc/init.d/firewall restart


uci set dropbear.@dropbear[0]='dropbear'
uci set dropbear.@dropbear[0].enable='1'
uci set dropbear.@dropbear[0].Interface='lan'
uci set dropbear.@dropbear[0].Port='22'
uci set dropbear.@dropbear[0].PasswordAuth='0'
uci set dropbear.@dropbear[0].RootLogin='1'
uci set dropbear.@dropbear[0].RootPasswordAuth='0'

uci commit dropbear

/etc/init.d/dropbear reload
