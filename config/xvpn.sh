#!/bin/sh

opkg install openvpn-openssl luci-app-openvpn


uci set network.xvpn='interface'
uci set network.xvpn.ifname='tun_xvpn'
uci set network.xvpn.proto='none'
uci set network.xvpn.auto='1'

uci commit network
/etc/init.d/network reload


uci set firewall.xvpn='zone'
uci set firewall.xvpn.name='xvpn'
uci set firewall.xvpn.network='xvpn'
uci set firewall.xvpn.input='ACCEPT'
uci set firewall.xvpn.forward='REJECT'
uci set firewall.xvpn.output='ACCEPT'
uci set firewall.xvpn.masq='1'

uci set firewall.openvpn_inbound_allow='rule'
uci set firewall.openvpn_inbound_allow.name='openvpn_inbound_allow'
uci set firewall.openvpn_inbound_allow.target='ACCEPT'
uci set firewall.openvpn_inbound_allow.src='*'
uci set firewall.openvpn_inbound_allow.proto='udp'
uci set firewall.openvpn_inbound_allow.dest_port='1194'

uci set firewall.lan2xvpn='forwarding'
uci set firewall.lan2xvpn.src='lan'
uci set firewall.lan2xvpn.dest='xvpn'

uci set firewall.xvpn2lan='forwarding'
uci set firewall.xvpn2lan.src='xvpn'
uci set firewall.xvpn2lan.dest='lan'

uci set firewall.xvpn2wan='forwarding'
uci set firewall.xvpn2wan.src='xvpn'
uci set firewall.xvpn2wan.dest='wan'

uci commit firewall
/etc/init.d/firewall restart


uci set openvpn.xvpn='openvpn'
uci set openvpn.xvpn.enabled='1'
uci set openvpn.xvpn.dev='tun_xvpn'
uci set openvpn.xvpn.server='10.8.0.0 255.255.255.0'
uci set openvpn.xvpn.port='1194'
uci set openvpn.xvpn.proto='udp'
uci set openvpn.xvpn.persist_key='1'
uci set openvpn.xvpn.persist_tun='1'
uci set openvpn.xvpn.verb='3'

uci set openvpn.xvpn.ca='/etc/openvpn/xvpn_ca.crt'
uci set openvpn.xvpn.cert='/etc/openvpn/xvpn_server.crt'
uci set openvpn.xvpn.key='/etc/openvpn/xvpn_server.key'
uci set openvpn.xvpn.ifconfig_pool_persist='xvpn-ipp.txt'
uci set openvpn.xvpn.dh='none'
uci set openvpn.xvpn.log='xvpn.log'
uci set openvpn.xvpn.status='xvpn-status.log'

uci set openvpn.xvpn.auth='SHA512'
uci set openvpn.xvpn.keysize='256'
uci set openvpn.xvpn.tls_server='1'
uci set openvpn.xvpn.tls_version_min='1.2'
uci set openvpn.xvpn.tls_cipher='TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384'
uci set openvpn.xvpn.cipher='AES-256-GCM'
uci set openvpn.xvpn.remote_cert_tls='client'

uci set openvpn.xvpn.user='nobody'
uci set openvpn.xvpn.group='nogroup'
uci set openvpn.xvpn.topology='subnet'
uci set openvpn.xvpn.keepalive='10 120'
uci set openvpn.xvpn.explicit_exit_notify='1'
uci delete openvpn.xvpn.push
uci add_list openvpn.xvpn.push='redirect-gateway def1'

uci commit openvpn

/etc/init.d/openvpn enable
/etc/init.d/openvpn restart
