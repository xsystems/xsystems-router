#!/bin/sh

rsync   --partial \
        --progress \
        --recursive \
        --links \
        --perms \
        --times \
        --rsh 'ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa' \
        files/ ${ROUTER_HOSTNAME}:/
