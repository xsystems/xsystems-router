#/bin/sh

while read -r MAC IP DOMAIN HOST_NAME ; do
    NAME=$(echo "${DOLLAR}{HOST_NAME}" | sed 's/-/_/g')

    uci set dhcp."${DOLLAR}{NAME}_host"='host'
    uci set dhcp."${DOLLAR}{NAME}_host".ip="${DOLLAR}{IP}"
    uci set dhcp."${DOLLAR}{NAME}_host".mac="${DOLLAR}{MAC}"
    uci set dhcp."${DOLLAR}{NAME}_host".name="${DOLLAR}{HOST_NAME}"

    uci set dhcp."${DOLLAR}{NAME}_domain"='domain'
    uci set dhcp."${DOLLAR}{NAME}_domain".ip="${DOLLAR}{IP}"
    uci set dhcp."${DOLLAR}{NAME}_domain".name="${DOLLAR}{DOMAIN}"
done <<EOF
${DNSMASQ_DATA}
EOF

uci set dhcp.@dhcp[0].leasetime='600s'

uci commit dhcp
/etc/init.d/dnsmasq restart
