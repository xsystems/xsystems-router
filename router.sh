#!/bin/sh

[ -f environment/variables.sh ] && . environment/variables.sh
[ -f environment/secrets.sh   ] && . environment/secrets.sh

print_info() {
    echo -e "\e[34m\e[1m$1\033[0m"
}

initial_setup() {
    print_info "INITIAL SETUP"
	ssh ${ROUTER_HOSTNAME} <<-EOF
		echo -e "${ROUTER_ROOT_PASSWORD}\n${ROUTER_ROOT_PASSWORD}" | passwd
		opkg update
		opkg install  ipset \
									diffutils \
									htop \
									rsyncd
	EOF
}

transfer_files () {
    print_info "TRANSFERING FILES"
    rsync -Prlpt files/ ${ROUTER_HOSTNAME}:/
}

apply_configuration() {
    for file in config/*.sh ; do
        print_info "APPLY ${file}"
        envsubst < "${file}" | ssh ${ROUTER_HOSTNAME}
    done
}

initial_setup
transfer_files
apply_configuration
