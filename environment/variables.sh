#!/bin/sh

[ -f environment/secrets.sh   ] && . environment/secrets.sh
[ -f environment/dnsmasq.dat   ] && export DNSMASQ_DATA="$(cat environment/dnsmasq.dat)"

export ROUTER_HOSTNAME="root@192.168.1.1"
export ROUTER_WIFI_SSID="npbrq5i7"

export ROUTER_NORDVPN_HOST="62.112.10.100"
export ROUTER_NORDVPN_PORT="443"
export ROUTER_NORDVPN_PROTO="tcp"

export VARIABLES_TO_SUBSTITUTE="${VARIABLES_TO_SUBSTITUTE}"'
$DNSMASQ_DATA
$ROUTER_HOSTNAME
$ROUTER_WIFI_SSID
$ROUTER_NORDVPN_HOST
$ROUTER_NORDVPN_PORT
$ROUTER_NORDVPN_PROTO
'
