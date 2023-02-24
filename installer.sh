#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    sudo su -s "$0"
    exit
fi

if [ $# -eq 3 ]; then
    if [ "$1" = 1 ]; then
        apt update -y && apt dist-upgrade -y && apt-get -y install apparmor
        wget get.docker.com -qO - | sh
        systemctl restart docker
        # reboot is recommended but is optional
        PASSWORD="$2" && docker run --name ssserver -p "$3":8388/tcp -p "$3":8388/udp -e SS_PASSWORD="${PASSWORD}" -e SS_PLUGIN=v2ray-plugin -e SS_PLUGIN_OPTS=server -d techieforfun/ssv2
    fi
fi
