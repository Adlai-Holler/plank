# Base image from SwiftDocker
# https://hub.docker.com/r/swiftdocker/swift/
FROM swiftdocker/swift
MAINTAINER Pinterest

# Vim config so we have an editor available
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        vim clang libicu-dev libcurl4-openssl-dev libssl-dev

ENV plank_HOME /usr/local/plank
ENV PATH ${plank_HOME}/.build/release:${PATH}

# Copy plank sources
WORKDIR /plank

