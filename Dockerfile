FROM rawmind/rancher-jvm8:0.0.1
MAINTAINER Raul Sanchez <rawmind@gmail.com>

# Set environment
ENV GOCD_REPO=https://download.go.cd/gocd/ \
  GOCD_RELEASE=go-agent-15.3.1 \
  GOCD_REVISION=2777 \
  GOCD_HOME=/opt/go-server \
  PATH=$GOCD_HOME:$PATH
ENV GOCD_RELEASE_ARCHIVE ${GOCD_RELEASE}-${GOCD_REVISION}.zip

# Install and configure gocd
RUN mkdir /var/log/go-server /var/run/go-server \
  && cd /opt && curl -sSL ${GOCD_REPO}/${GOCD_RELEASE_ARCHIVE} -O && unzip ${GOCD_RELEASE_ARCHIVE} && rm ${GOCD_RELEASE_ARCHIVE} \
  && ln -s /opt/${GOCD_RELEASE} ${GOCD_HOME} \
  && chmod 774 ${GOCD_HOME}/*.sh
  && mkdir -p ${GOCD_HOME}/work

WORKDIR ${GOCD_HOME}

ENTRYPOINT ["${GOCD_HOME}/agent.sh"]
