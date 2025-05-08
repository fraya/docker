#!/bin/bash

set -e

# distributions to build for
DEBIAN_DIST="bookworm"
UBUNTU_DIST="noble"

# default distro used for tag
DEFAULT_DIST=${DEBIAN_DIST}

RELEASE_DISTS="debian:${DEBIAN_DIST} ubuntu:${UBUNTU_DIST}"
CURRENT_DISTS="debian:${DEBIAN_DIST} ubuntu:${UBUNTU_DIST}"

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


# Tag default distro for release version
docker tag opendylan:release-${DEFAULT_DIST} opendylan:release

# build images with current opendylan
for dist in ${CURRENT_DISTS}; do
    distrelease=$(distrel ${dist})
    docker build ./dist \
           -f Dockerfile.current \
           -t opendylan:current-${distrelease} \
           --build-arg OPENDYLAN_BASE=${dist} \
           "$@"
done

# Tag default distro for current
docker tag opendylan:current-${DEFAULT_DIST} opendylan:current

# use the current image as latest for now
docker tag opendylan:current          opendylan:latest

