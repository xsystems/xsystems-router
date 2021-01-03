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
uci set firewall.nordvpn.masq='1'
uci set firewall.nordvpn.mtu_fix='1'
uci delete firewall.nordvpn.network
uci add_list firewall.nordvpn.network='nordvpn'

uci set firewall.lan2nordvpn='forwarding'
uci set firewall.lan2nordvpn.src='lan'
uci set firewall.lan2nordvpn.dest='nordvpn'

uci commit firewall
/etc/init.d/firewall restart


uci set openvpn.nordvpn='openvpn'
uci set openvpn.nordvpn.enabled='1'
uci set openvpn.nordvpn.dev='tun_nordvpn'
uci set openvpn.nordvpn.client='1'
uci set openvpn.nordvpn.remote='${ROUTER_NORDVPN_HOST}'
uci set openvpn.nordvpn.port='${ROUTER_NORDVPN_PORT}'
uci set openvpn.nordvpn.proto='${ROUTER_NORDVPN_PROTO}'
uci set openvpn.nordvpn.persist_key='1'
uci set openvpn.nordvpn.persist_tun='1'
uci set openvpn.nordvpn.verb='3'

uci set openvpn.nordvpn.ca='/etc/openvpn/nordvpn_ca.crt'
uci set openvpn.nordvpn.tls_auth='/etc/openvpn/nordvpn_ta.key'
uci set openvpn.nordvpn.auth_user_pass='/etc/openvpn/nordvpn.credentials'
uci set openvpn.nordvpn.log='nordvpn.log'
uci set openvpn.nordvpn.status='nordvpn-status.log'

uci set openvpn.nordvpn.resolv_retry='infinite'
uci set openvpn.nordvpn.remote_random='1'
uci set openvpn.nordvpn.nobind='1'
uci set openvpn.nordvpn.tun_mtu='1500'
uci set openvpn.nordvpn.tun_mtu_extra='32'
uci set openvpn.nordvpn.mssfix='1450'
uci set openvpn.nordvpn.ping='15'
uci set openvpn.nordvpn.ping_restart='0'
uci set openvpn.nordvpn.ping_timer_rem='1'
uci set openvpn.nordvpn.reneg_sec='0'
uci set openvpn.nordvpn.comp_lzo='no'
uci set openvpn.nordvpn.remote_cert_tls='server'
uci set openvpn.nordvpn.pull='1'
uci set openvpn.nordvpn.fast_io='1'
uci set openvpn.nordvpn.cipher='AES-256-CBC'
uci set openvpn.nordvpn.auth='SHA512'
uci set openvpn.nordvpn.key_direction='1'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn start
