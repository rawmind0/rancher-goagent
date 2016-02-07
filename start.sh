#!/usr/bin/env bash

set -e

function log {
    echo `date` $ME - $@
}

function checkrancher {
    log "checking rancher network..."
    a="1"
    while  [ $a -eq 1 ];
    do
        a="`ip a s dev eth0 &> /dev/null; echo $?`" 
        sleep 1
    done

    b="1"
    while [ $b -eq 1 ]; 
    do
        b="`ping -c 1 rancher-metadata &> /dev/null; echo $?`"
        sleep 1 
    done
}

checkrancher

DOCKER_HOST=tcp://$(curl http://rancher-metadata/latest/self/host/agent_ip):2375

export DOCKER_HOST

log "[ Starting gocd agent... ]"
/opt/go-agent/agent.sh
