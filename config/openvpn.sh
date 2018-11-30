#!/bin/sh

opkg install openvpn-openssl luci-app-openvpn


uci add network interface
uci set network.@interface[-1].name='xvpn'
uci set network.@interface[-1].ifname='tun_xvpn'
uci set network.@interface[-1].proto='none'
uci set network.@interface[-1].auto='true'

uci commit network
/etc/init.d/network reload


uci add firewall zone
uci set firewall.@zone[-1].name='xvpn'
uci set firewall.@zone[-1].network='xvpn'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].forward='REJECT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].masq='true'

uci add firewall rule
uci set firewall.@rule[-1].name='Allow-OpenVPN-Inbound'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].src='*'
uci set firewall.@rule[-1].proto='udp'
uci set firewall.@rule[-1].dest_port='1194'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='xvpn'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='xvpn'
uci set firewall.@forwarding[-1].dest='lan'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='xvpn'
uci set firewall.@forwarding[-1].dest='wan'

uci commit firewall
/etc/init.d/firewall restart


uci add openvpn openvpn
uci set openvpn.@openvpn[-1].name='xvpn'
uci set openvpn.@openvpn[-1].enabled='true'
uci set openvpn.@openvpn[-1].verb='3'
uci set openvpn.@openvpn[-1].port='1194'
uci set openvpn.@openvpn[-1].proto='udp'
uci set openvpn.@openvpn[-1].dev='tun_xvpn'
uci set openvpn.@openvpn[-1].topology='subnet'
uci set openvpn.@openvpn[-1].server='10.8.0.0 255.255.255.0'
uci set openvpn.@openvpn[-1].keepalive='10 120'
uci set openvpn.@openvpn[-1].explicit_exit_notify='true'
uci set openvpn.@openvpn[-1].persist_key='true'
uci set openvpn.@openvpn[-1].persist_tun='true'
uci set openvpn.@openvpn[-1].ifconfig_pool_persist='openvpn-ipp.txt'
uci set openvpn.@openvpn[-1].ca='/etc/openvpn/ca.crt'
uci set openvpn.@openvpn[-1].cert='/etc/openvpn/server.crt'
uci set openvpn.@openvpn[-1].key='/etc/openvpn/server.key'
uci set openvpn.@openvpn[-1].dh='/etc/openvpn/dh.pem'
uci set openvpn.@openvpn[-1].user='nobody'
uci set openvpn.@openvpn[-1].group='nogroup'
uci set openvpn.@openvpn[-1].log='openvpn.log'
uci set openvpn.@openvpn[-1].status='openvpn-status.log'

uci add_list openvpn.@openvpn[-1].push='redirect-gateway def1'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn start
