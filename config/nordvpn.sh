#!/bin/sh

opkg install openvpn-openssl luci-app-openvpn


uci add network interface
uci set network.@interface[-1].name='nordvpn'
uci set network.@interface[-1].ifname='tun_nordvpn'
uci set network.@interface[-1].proto='none'

uci del network.wan.dns
uci add_list network.wan.dns='103.86.96.100'
uci add_list network.wan.dns='103.86.99.100'
uci set network.wan.peerdns='0'

uci commit network
/etc/init.d/network reload


uci add firewall zone
uci set firewall.@zone[-1].name='nordvpn'
uci set firewall.@zone[-1].input='REJECT'
uci set firewall.@zone[-1].forward='REJECT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].masq='true'
uci set firewall.@zone[-1].mtu_fix='true'
uci add_list firewall.@zone[-1].network="nordvpn"

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='nordvpn'

uci commit firewall
/etc/init.d/firewall restart


uci add openvpn openvpn
uci set openvpn.@openvpn[-1].name='nordvpn'
uci set openvpn.@openvpn[-1].enabled='true'
uci set openvpn.@openvpn[-1].dev='tun_nordvpn'
uci set openvpn.@openvpn[-1].proto='tcp'
uci set openvpn.@openvpn[-1].remote='${ROUTER_NORDVPN_REMOTE}'
uci set openvpn.@openvpn[-1].config="/etc/openvpn/nordvpn.ovpn"
uci set openvpn.@openvpn[-1].auth_user_pass='/etc/openvpn/nordvpn.credentials'
uci set openvpn.@openvpn[-1].log='nordvpn.log'
uci set openvpn.@openvpn[-1].status='nordvpn-status.log'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn start
