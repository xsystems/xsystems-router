#!/bin/sh

opkg install openvpn-openssl luci-app-openvpn


uci set network.nordvpn='interface'
uci set network.nordvpn.ifname='tun_nordvpn'
uci set network.nordvpn.proto='none'

uci delete network.wan.dns
uci add_list network.wan.dns='103.86.96.100'
uci add_list network.wan.dns='103.86.99.100'
uci set network.wan.peerdns='0'

uci commit network
/etc/init.d/network reload


uci set firewall.nordvpn='zone'
uci set firewall.nordvpn.name='nordvpn'
uci set firewall.nordvpn.input='REJECT'
uci set firewall.nordvpn.forward='REJECT'
uci set firewall.nordvpn.output='ACCEPT'
uci set firewall.nordvpn.masq='true'
uci set firewall.nordvpn.mtu_fix='true'
uci delete firewall.nordvpn.network
uci add_list firewall.nordvpn.network='nordvpn'

uci set firewall.lan2nordvpn='forwarding'
uci set firewall.lan2nordvpn.src='lan'
uci set firewall.lan2nordvpn.dest='nordvpn'

uci commit firewall
/etc/init.d/firewall restart


uci set openvpn.nordvpn='openvpn'
uci set openvpn.nordvpn.enabled='true'
uci set openvpn.nordvpn.dev='tun_nordvpn'
uci set openvpn.nordvpn.proto='tcp'
uci set openvpn.nordvpn.remote='${ROUTER_NORDVPN_REMOTE}'
uci set openvpn.nordvpn.config="/etc/openvpn/nordvpn.ovpn"
uci set openvpn.nordvpn.auth_user_pass='/etc/openvpn/nordvpn.credentials'
uci set openvpn.nordvpn.log='nordvpn.log'
uci set openvpn.nordvpn.status='nordvpn-status.log'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn start
