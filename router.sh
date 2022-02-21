#!/bin/sh

[ -f environment/variables.sh ] && . environment/variables.sh

print_info() {
    echo -e "\e[34m\e[1m$1\033[0m"
}

for file in scripts/*.sh ; do
    print_info "APPLY ${file}"

    if [ `expr "${file}" : "^scripts/[0-9][0-9]_l_*"` -gt 0 ] ; then
        . "${file}"
    else
        DOLLAR=$ envsubst < "${file}" | ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa "${ROUTER_HOSTNAME}"
    fi
done
