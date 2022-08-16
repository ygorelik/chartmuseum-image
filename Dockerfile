# Command To build this image 
#       docker build --no-cache -t chartmuseum-image .
#
# The helm repository configured for local file system storage inside the container in the directory /chartmuseum/storage.
# The container exposes TCP port 8080 for external access. Usually this port is mapped to some other external port
# to avoid collisions on web servers that have already using port 8080.
#
# To run the docker with port mapping:
#
# docker run -td --name chartmuseum -p 8443:8080 chartmuseum-image
#

FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y net-tools vim curl && \
    apt-get clean

RUN mkdir /chartmuseum && mkdir /chartmuseum/storage && cd /chartmuseum && touch cm.log
RUN curl https://raw.githubusercontent.com/helm/chartmuseum/main/scripts/get-chartmuseum | bash
COPY ./index-cache.yaml /chartmuseum/storage/

EXPOSE 8080

ENV DEBUG_OPTION=

ENTRYPOINT chartmuseum $DEBUG_OPTION --storage=local --storage-local-rootdir=/chartmuseum/storage > /chartmuseum/cm.log

