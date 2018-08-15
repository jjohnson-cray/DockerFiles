FROM alpine:latest

MAINTAINER John T. Johnson <jjohnson@cray.com>

LABEL Description="CrayStack CLI Tools Docker Container"

# Alpine-based installation

RUN apk add --update \
  # bash \
  python-dev \
  py-pip \
  py-setuptools \
  ca-certificates \
  gcc \
  musl-dev \
  linux-headers \
  libffi-dev \
  openssl-dev \
  && pip install --upgrade --no-cache-dir pip \
  && pip install --upgrade setuptools \
     python-barbicanclient python-ceilometerclient python-cinderclient python-cloudkittyclient \
     python-designateclient python-fuelclient python-glanceclient python-heatclient \
     python-magnumclient python-manilaclient python-mistralclient python-monascaclient python-muranoclient \
     python-neutronclient python-novaclient python-saharaclient python-senlinclient python-swiftclient \
  && apk del gcc musl-dev linux-headers \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted
# Example.  This command takes the PWD and maps it to /data within the container
#           so copy your openrc.sh file to $PWD before running the container
#           After running your container, go to /data and source your openrc.sh file
# Ex. `docker run -v $PWD:/data `
VOLUME ["/data"]

# Ex. `docker run -ti jmcvea/openstack-client openstack server list`
CMD ["/bin/sh"]
