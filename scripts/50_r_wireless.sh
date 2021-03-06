#!/bin/sh

uci set wireless.radio0.disabled='0'
uci set wireless.radio0.htmode='VHT40'
uci set wireless.radio0.channel='36'

uci set wireless.default_radio0.ssid='${ROUTER_WIFI_SSID}'
uci set wireless.default_radio0.encryption='psk2+ccmp'
uci set wireless.default_radio0.key='${ROUTER_WIFI_KEY}'

uci set wireless.radio1.disabled='0'
uci set wireless.radio1.htmode='HT40'
uci set wireless.radio1.channel='13'

uci set wireless.default_radio1.ssid='${ROUTER_WIFI_SSID}'
uci set wireless.default_radio1.encryption='psk2+ccmp'
uci set wireless.default_radio1.key='${ROUTER_WIFI_KEY}'

uci set wireless.radio2.disabled='0'
uci set wireless.radio2.htmode='VHT40'
uci set wireless.radio2.channel='48'

uci set wireless.default_radio2.ssid='${ROUTER_WIFI_SSID}'
uci set wireless.default_radio2.encryption='psk2+ccmp'
uci set wireless.default_radio2.key='${ROUTER_WIFI_KEY}'

uci commit wireless

/etc/init.d/network reload
