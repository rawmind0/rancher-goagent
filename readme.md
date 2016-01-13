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
-h go-agent.${DNS_DOMAIN} \
-v <work-volume> /opt/go-agent/work
<registry>/rancher-goagent:<version>

DEPLOY_ENV -> Deploy environment
```

To config:

Change and add these env variables to the docker deploy.

```
SERVER_MEM="512m"
SERVER_MAX_MEM="1024m"
SERVER_MAX_PERM_GEN="256m"
SERVER_MIN_PERM_GEN="128m"
SERVER_DIR="$GOCD_HOME"
SERVER_WORK_DIR="$SERVER_DIR"
GO_SERVER=<IP_GOSERVER>

```
