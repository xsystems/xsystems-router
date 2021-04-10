#!/bin/sh

rsync -Prlpt files/ ${ROUTER_HOSTNAME}:/
