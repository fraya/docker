#!/bin/bash

docker build --network host \
       -f Dockerfile.opendylan-release \
       --build-arg "OPENDYLAN_BASE=debian:bullseye" \
       -t opendylan:release \
       -t opendylan:release-bullseye \
       .

docker build --network host \
       -f Dockerfile.opendylan-current \
       --build-arg "OPENDYLAN_BASE=debian:bullseye" \
       -t opendylan:current \
       -t opendylan:current-bullseye \
       -t opendylan:latest \
       -t opendylan:latest-bullseye \
       .
