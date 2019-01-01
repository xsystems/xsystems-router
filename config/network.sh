#!/bin/sh

uci set wireless.radio0.disabled='false'
uci set wireless.radio0.htmode='VHT80'
uci set wireless.radio0.channel='36'

uci set wireless.default_radio0.ssid='npbrq5i7'
uci set wireless.default_radio0.encryption='psk2+ccmp'
uci set wireless.default_radio0.key='${ROUTER_WIFI_KEY}'

uci set wireless.radio1.disabled='false'
uci set wireless.radio1.htmode='HT40'
uci set wireless.radio1.channel='8'

uci set wireless.default_radio1.ssid='npbrq5i7'
uci set wireless.default_radio1.encryption='psk2+ccmp'
uci set wireless.default_radio1.key='${ROUTER_WIFI_KEY}'

uci commit wireless

/etc/init.d/network reload
