#!/bin/sh

[ -f ./environment.sh ] && . ./environment.sh

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


for file in $(cd files; find * -type d -links 2)
do
    transfering "/${file}"
    scp -r "files/${file}" "${ROUTER_HOSTNAME}:`dirname /${file}`"
done


configuration_start "General"
ssh ${ROUTER_HOSTNAME} << EOF
  echo -e "${ROUTER_ROOT_PASSWORD}\n${ROUTER_ROOT_PASSWORD}" | passwd
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
  envsubst < "${file}" | ssh ${ROUTER_HOSTNAME}
  configuration_end ${filename}
done
