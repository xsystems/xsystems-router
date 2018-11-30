#!/bin/sh

ROUTER_HOSTNAME="root@192.168.128.1"
ROUTER_NORDVPN_REMOTE="62.112.10.100 443"


transfering () {
  echo -e "\e[33m\e[1mTransfering:\033[0m $1"
}

configuration_start () {
  name=`echo $1 | awk '{print toupper($0)}'`
  echo -e "\e[33m\e[1m### $name START ###\033[0m"
}

configuration_end () {
  name=`echo $1 | awk '{print toupper($0)}'`
  echo -e "\e[33m\e[1m### $name END ###\033[0m"
}


for file in $(cd files; find * -type f)
do
    transfering "/$file"
    ssh ${ROUTER_HOSTNAME} "mkdir -p `dirname /${file}`"
    cat "files/${file}" | ssh ${ROUTER_HOSTNAME} "cat > /${file}"
done


configuration_start "General"
ssh ${ROUTER_HOSTNAME} << EOF
  opkg update
  opkg install  ipset \
                diffutils \
                htop
EOF
configuration_end "General"

for file in config/*
do
  filename=`basename "${file%.*}"`
  configuration_start ${filename}
  ssh ${ROUTER_HOSTNAME} < "${file}"
  configuration_end ${filename}
done
