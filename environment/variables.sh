#!/bin/sh

[ -f environment/secrets.sh   ] && . environment/secrets.sh
[ -f environment/dnsmasq.dat   ] && export DNSMASQ_DATA="$(cat environment/dnsmasq.dat)"

export ROUTER_HOSTNAME="root@192.168.1.1"
export ROUTER_WIFI_SSID="npbrq5i7"

export VARIABLES_TO_SUBSTITUTE="${VARIABLES_TO_SUBSTITUTE}"'
$DNSMASQ_DATA
$ROUTER_HOSTNAME
$ROUTER_WIFI_SSID
'
