#!/bin/sh

[ -f environment/secrets.sh ] && . environment/secrets.sh
[ -f environment/static_leases.dat ] && export STATIC_LEASES_DATA="$(cat environment/static_leases.dat)"
[ -f environment/hostnames.dat ] && export HOSTNAMES_DATA="$(cat environment/hostnames.dat)"

export ROUTER_HOSTNAME="root@192.168.1.1"
export ROUTER_WIFI_SSID="npbrq5i7"
