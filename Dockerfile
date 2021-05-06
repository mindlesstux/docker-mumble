# Container image that runs your code
FROM alpine:latest

# Install Bash
RUN apk update && apk upgrade&& apk add bash bash-completion

# Credit myself...
LABEL maintainer="mindlesstux@gmail.com"

# What release version are we going to unpack and "install"
ARG MURMUR_RELEASE=1.3.4
ENV MURMUR_STATIC_URL=https://github.com/mumble-voip/mumble/releases/download/${MURMUR_RELEASE}/murmur-static_x86-${MURMUR_RELEASE}.tar.bz2

# Where the sausage will sit
RUN mkdir -p /murmur/binary && mkdir -p /murmur/cfglog

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Work in the sausage pit
WORKDIR /murmur

# Get the murmer static tar.bz2, untar, and move files around
ADD ${MURMUR_STATIC_URL} /murmur
RUN tar -xjf /murmur/murmur-static_x86-${MURMUR_RELEASE}.tar.bz2 -C /murmur/binary \
   && rm -f /murmur/murmur-static_x86-${MURMUR_RELEASE}.tar.bz2 \
   && ln -s /murmur/binary/murmur-static_x86-${MURMUR_RELEASE} /murmur/binary/murmur-static_x86

# CHMOD the entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 64738 64738/udp

# Set running user
USER 10000:10000

# Where cfg, log, and sqlite file should go
VOLUME ["/murmur/cfglog"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]