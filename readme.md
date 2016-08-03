rancher-gocd-agent
=======================

Builds a docker image for gocd agent based in rancher-base

To build:

```
docker build -t <registry>/rancher-goagent:<version> .
```

To deploy:

Gocd server: Starts gocd agent and configures it

```
docker run -td --name go-agent \
-v <work-volume> /opt/go-agent/work \
<registry>/rancher-goagent:<version>

```

NOTE: By default, docker client 1.12.0 is installed. You could override that setting env variable $DOCKER_VERSION if you need it.


# How it works

* The docker has the entrypoint /usr/bin/start.sh, that install docker client and runs go-agent.
* Config params could be modified overriding these env variables:

```
AGENT_MEM="128m"
AGENT_MAX_MEM="256m"
GO_SERVER=<IP_GOSERVER>
GO_SERVER_PORT="8153"
JVM_DEBUG_PORT="5006"
AGENT_WORK_DIR="$GOCD_HOME/work"
DOCKER_VERSION="1.12.0"

```
