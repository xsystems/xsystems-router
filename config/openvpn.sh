#!/bin/sh

opkg install openvpn-openssl luci-app-openvpn


uci set network.vpn0='interface'
uci set network.vpn0.ifname='tun0'
uci set network.vpn0.proto='none'
uci set network.vpn0.auto='true'

uci commit network
/etc/init.d/network reload


uci set firewall.vpn='zone'
uci set firewall.vpn.name='vpn'
uci set firewall.vpn.network='vpn0'
uci set firewall.vpn.input='ACCEPT'
uci set firewall.vpn.forward='REJECT'
uci set firewall.vpn.output='ACCEPT'
uci set firewall.vpn.masq='true'

uci set firewall.Allow_OpenVPN_Inbound='rule'
uci set firewall.Allow_OpenVPN_Inbound.target='ACCEPT'
uci set firewall.Allow_OpenVPN_Inbound.src='*'
uci set firewall.Allow_OpenVPN_Inbound.proto='udp'
uci set firewall.Allow_OpenVPN_Inbound.dest_port='1194'

uci set firewall.forwarding_vpn_lan_in='forwarding'
uci set firewall.forwarding_vpn_lan_in.src='lan'
uci set firewall.forwarding_vpn_lan_in.dest='vpn'

uci set firewall.forwarding_vpn_lan_out='forwarding'
uci set firewall.forwarding_vpn_lan_out.src='vpn'
uci set firewall.forwarding_vpn_lan_out.dest='lan'

uci set firewall.forwarding_vpn_wan_out='forwarding'
uci set firewall.forwarding_vpn_wan_out.src='vpn'
uci set firewall.forwarding_vpn_wan_out.dest='wan'

uci commit firewall
/etc/init.d/firewall restart


uci del openvpn.openvpn0
uci set openvpn.openvpn0='openvpn'
uci set openvpn.openvpn0.enabled='true'
uci set openvpn.openvpn0.verb='3'
uci set openvpn.openvpn0.port='1194'
uci set openvpn.openvpn0.proto='udp'
uci set openvpn.openvpn0.dev='tun'
uci set openvpn.openvpn0.topology='subnet'
uci set openvpn.openvpn0.server='10.8.0.0 255.255.255.0'
uci set openvpn.openvpn0.keepalive='10 120'
uci set openvpn.openvpn0.explicit_exit_notify='true'
uci set openvpn.openvpn0.persist_key='true'
uci set openvpn.openvpn0.persist_tun='true'
uci set openvpn.openvpn0.ifconfig_pool_persist='openvpn-ipp.txt'
uci set openvpn.openvpn0.ca='/etc/openvpn/ca.crt'
uci set openvpn.openvpn0.cert='/etc/openvpn/server.crt'
uci set openvpn.openvpn0.key='/etc/openvpn/server.key'
uci set openvpn.openvpn0.dh='/etc/openvpn/dh.pem'
uci set openvpn.openvpn0.user='nobody'
uci set openvpn.openvpn0.group='nogroup'
uci set openvpn.openvpn0.log='openvpn.log'
uci set openvpn.openvpn0.status='openvpn-status.log'

uci add_list openvpn.openvpn0.push='redirect-gateway def1'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn start
