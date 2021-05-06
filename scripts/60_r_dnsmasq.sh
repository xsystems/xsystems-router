#/bin/sh

while uci -q delete dhcp.@host[0] ; do :; done
while read -r MAC IP HOST_NAME ; do
    uci add dhcp host
    uci set dhcp.@host[-1].ip="${DOLLAR}{IP}"
    uci set dhcp.@host[-1].mac="${DOLLAR}{MAC}"
    uci set dhcp.@host[-1].name="${DOLLAR}{HOST_NAME}"
done <<EOF
${STATIC_LEASES_DATA}
EOF

while uci -q delete dhcp.@domain[0] ; do :; done
while read -r IP DOMAIN ; do
    uci add dhcp domain
    uci set dhcp.@domain[-1].ip="${DOLLAR}{IP}"
    uci set dhcp.@domain[-1].name="${DOLLAR}{DOMAIN}"
done <<EOF
${HOSTNAMES_DATA}
EOF

uci set dhcp.@dhcp[0].leasetime='600s'

uci commit dhcp
/etc/init.d/dnsmasq restart
