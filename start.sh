#!/usr/bin/env bash

set -e

function log {
    echo `date` $ME - $@
}

function checkrancher {
    log "checking rancher network..."

    a="`ip a s dev eth0 &> /dev/null; echo $?`" 
    while  [ $a -eq 1 ];
    do
        a="`ip a s dev eth0 &> /dev/null; echo $?`" 
        sleep 1
    done

    b="`ping -c 1 rancher-metadata &> /dev/null; echo $?`"
    while [ $b -eq 1 ]; 
    do
        b="`ping -c 1 rancher-metadata &> /dev/null; echo $?`"
        sleep 1 
    done
}

checkrancher

echo `hostname` > /opt/go-agent/config/guid.txt

log "[ Starting gocd agent... ]"
/opt/go-agent/agent.sh
