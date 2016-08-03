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

function installDocker {
    DOCKER_VERSION=${DOCKER_VERSION:-"1.12.0"} 
    DOCKER_BIN=${DOCKER_BIN:-"/usr/bin/docker"}
    log "[ Checking Docker client ${DOCKER_VERSION} ... ]"

    if [ ! -e ${DOCKER_BIN} ]; then
        log "[ Installing Docker client ${DOCKER_VERSION} ... ]"

        If [ "$DOCKER_VERSION" == "1.10.3" ]; then
                DOCKER_EXTRACT_FILE="usr/local/bin/docker"
        else
                DOCKER_EXTRACT_FILE="docker/docker"
        fi
        
        cd /tmp
        curl -Ss https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz  | tar zxvf - ${DOCKER_EXTRACT_FILE} 
        if [ $? -eq 0 ]; then 
            chmod 755 /tmp/${DOCKER_EXTRACT_FILE}
            mv /tmp/${DOCKER_EXTRACT_FILE} ${DOCKER_BIN}
        else
            log "[ ERROR ]"
            exit 1
        fi
    fi
}

checkrancher
installDocker

echo `hostname` > /opt/go-agent/config/guid.txt

log "[ Starting gocd agent... ]"
/opt/go-agent/agent.sh
