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
-v <work-volume> /opt/go-agent/work
<registry>/rancher-goagent:<version>

```


# How it works

* The docker has the entrypoint /usr/bin/start.sh, that runs go-server.
* Config params could be modified overriding these env variables:

```
AGENT_MEM="128m"
AGENT_MAX_MEM="256m"
GO_SERVER=<IP_GOSERVER>
GO_SERVER_PORT="8153"
JVM_DEBUG_PORT="5006"
AGENT_WORK_DIR="$GOCD_HOME/work"

```
