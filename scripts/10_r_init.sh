#!/bin/sh

opkg update
opkg install  	ipset \
                diffutils \
                htop \
                rsyncd
