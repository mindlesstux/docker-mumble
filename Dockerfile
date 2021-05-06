ARG murmur-release=1.3.4

# Container image that runs your code
FROM alpine:latest

# Where the sausage will sit
RUN mkdir -p /murmur

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Work in the sausage pit
WORKDIR /murmur

# Get the murmer static tar.bz2
ADD https://github.com/mumble-voip/mumble/releases/download/${murmur-release}/murmur-static_x86-${murmur-release}.tar.bz2 /murmur
RUN tar -xjf /usr/src/things/murmur-static_x86-${murmur-release}.tar.bz2

# CHMOD the entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 64738 64738/udp

# Set running user
USER mumble

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
