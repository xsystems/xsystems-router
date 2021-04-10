#/bin/sh

while read -r MAC IP DOMAIN HOST_NAME ; do
    NAME=$(echo "${HOST_NAME}" | sed 's/-/_/g')

    uci set dhcp."${NAME}_host"='host'
    uci set dhcp."${NAME}_host".ip="${IP}"
    uci set dhcp."${NAME}_host".mac="${MAC}"
    uci set dhcp."${NAME}_host".name="${HOST_NAME}"

    uci set dhcp."${NAME}_domain"='domain'
    uci set dhcp."${NAME}_domain".ip="${IP}"
    uci set dhcp."${NAME}_domain".name="${DOMAIN}"
done <<EOF
${DNSMASQ_DATA}
EOF

uci set dhcp.@dhcp[0].leasetime='600s'

uci commit dhcp
/etc/init.d/dnsmasq restart
