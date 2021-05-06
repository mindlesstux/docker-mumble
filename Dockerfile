ARG murmur-release=1.3.4

# Container image that runs your code
FROM alpine:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Get the murmer static tar.bz2
RUN wget https://github.com/mumble-voip/mumble/releases/download/${murmur-release}/murmur-static_x86-${murmur-release}.tar.bz2

# CHMOD the entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
