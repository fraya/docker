#!/bin/bash

set -e

# distributions to build for
RELEASE_DISTS="debian:buster debian:bullseye ubuntu:impish ubuntu:jammy"
CURRENT_DISTS="debian:buster debian:bullseye ubuntu:impish ubuntu:jammy"

# helper function
distrel() {
    local dist="$1"
    echo ${dist} | cut -d: -f 2
}

# build images with release opendylan
for dist in ${RELEASE_DISTS}; do
    distrelease=$(distrel ${dist})
    docker build ./dist \
           -f Dockerfile.release \
           -t opendylan:release-${distrelease} \
           --build-arg OPENDYLAN_BASE=${dist} \
           "$@"
done

# use bullseye as default for release
docker tag opendylan:release-bullseye opendylan:release

# build images with current opendylan
for dist in ${CURRENT_DISTS}; do
    distrelease=$(distrel ${dist})
    docker build ./dist \
           -f Dockerfile.current \
           -t opendylan:current-${distrelease} \
           --build-arg OPENDYLAN_BASE=${dist} \
           "$@"
done

# use bullseye as default for current
docker tag opendylan:current-bullseye opendylan:current

# use the current image as latest for now
docker tag opendylan:current          opendylan:latest

