#!/bin/sh

opkg install openvpn-openssl luci-app-openvpn


uci set network.vpn1='interface'
uci set network.vpn1.ifname='tun1'
uci set network.vpn1.proto='none'
uci set network.vpn1.auto='true'

uci del network.wan.dns
uci add_list network.wan.dns='162.242.211.137'
uci add_list network.wan.dns='78.46.223.24'
uci set network.wan.peerdns='0'

uci commit network
/etc/init.d/network reload


uci set firewall.nordvpn='zone'
uci set firewall.nordvpn.name='nordvpn'
uci set firewall.nordvpn.network='vpn1'
uci set firewall.nordvpn.input='REJECT'
uci set firewall.nordvpn.forward='REJECT'
uci set firewall.nordvpn.output='ACCEPT'
uci set firewall.nordvpn.masq='true'
uci set firewall.nordvpn.mtu_fix='true'

uci set firewall.forwarding_nordvpn_lan='forwarding'
uci set firewall.forwarding_nordvpn_lan.src='lan'
uci set firewall.forwarding_nordvpn_lan.dest='nordvpn'

uci commit firewall
/etc/init.d/firewall restart


uci del openvpn.nordvpn
#uci set openvpn.nordvpn='openvpn'
#uci set openvpn.nordvpn.enabled='true'
#uci set openvpn.nordvpn.verb='3'
#uci set openvpn.nordvpn.client='true'
#uci set openvpn.nordvpn.dev='tun'
#uci set openvpn.nordvpn.proto='tcp'
#uci set openvpn.nordvpn.remote='${NORDVPN_REMOTE}'
#uci set openvpn.nordvpn.remote_random='true'
#uci set openvpn.nordvpn.nobind='true'
#uci set openvpn.nordvpn.persist_key='true'
#uci set openvpn.nordvpn.persist_tun='true'
#uci set openvpn.nordvpn.ping='15'
#uci set openvpn.nordvpn.ping_restart='0'
#uci set openvpn.nordvpn.ping_timer_rem='true'
#uci set openvpn.nordvpn.reneg_sec='0'
#uci set openvpn.nordvpn.remote_cert_tls='server'
#uci set openvpn.nordvpn.compress='lzo'
#uci set openvpn.nordvpn.fast_io='true'
#uci set openvpn.nordvpn.cipher='AES-256-CBC'
#uci set openvpn.nordvpn.auth='SHA512'
#uci set openvpn.nordvpn.ca='/etc/openvpn/nordvpn.ca.cert'
#uci set openvpn.nordvpn.tls_auth='/etc/openvpn/nordvpn.tls.key'
#uci set openvpn.nordvpn.auth_user_pass='/etc/openvpn/nordvpn.credentials'
#uci set openvpn.nordvpn.log='nordvpn.log'
#uci set openvpn.nordvpn.status='nordvpn-status.log'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn start




#uci set openvpn.nordvpn.resolv-retry='infinite'
#uci set openvpn.nordvpn.tun-mtu='1500'
#uci set openvpn.nordvpn.tun-mtu-extra='32'
#uci set openvpn.nordvpn.mssfix='1450'
#uci set openvpn.nordvpn.pull='true'
#uci set openvpn.nordvpn.key-direction='true'
