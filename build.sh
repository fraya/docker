#!/bin/bash

set -e

DISTS="debian:buster debian:bullseye"
#" ubuntu:impish ubuntu:jammy"

distrel() {
    local dist="$1"
    echo ${dist} | cut -d: -f 2
}

# build images with release opendylan
for dist in ${DISTS}; do
    distrelease=$(distrel ${dist})
    docker build --network host \
           -f Dockerfile.opendylan-release \
           --build-arg OPENDYLAN_BASE=${dist} \
           -t opendylan:release-${distrelease} \
           ./dist
done

docker tag opendylan:release-buster opendylan:release

# build images with current opendylan
for dist in ${DISTS}; do
    distrelease=$(distrel ${dist})
    docker build --network host \
           -f Dockerfile.opendylan-current \
           --build-arg OPENDYLAN_BASE=${dist} \
           -t opendylan:current-${distrelease} \
 	   ./dist
done

docker tag opendylan:current-buster opendylan:current

# use the current image as latest for now

docker tag opendylan:current-buster   opendylan:latest
docker tag opendylan:current-buster   opendylan:latest-buster
docker tag opendylan:current-bullseye opendylan:latest-bullseye
