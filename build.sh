#!/bin/bash

docker build --network host \
       -f Dockerfile.opendylan-release \
       --build-arg "OPENDYLAN_BASE=debian:bullseye" \
       -t opendylan:release-base \
       -t opendylan:release-base-bullseye \
       .

docker build --network host \
       -f Dockerfile.opendylan-current \
       --build-arg "OPENDYLAN_BASE=debian:bullseye" \
       -t opendylan:current-base \
       -t opendylan:current-base-bullseye \
	   .

docker build --network host \
       -f Dockerfile.opendylan-devel \
       --build-arg "OPENDYLAN_BASE=opendylan:release-base-bullseye" \
       -t opendylan:release \
       -t opendylan:release-bullseye \
       empty

docker build --network host \
       -f Dockerfile.opendylan-devel \
       --build-arg "OPENDYLAN_BASE=opendylan:current-base-bullseye" \
       -t opendylan:current \
       -t opendylan:current-bullseye \
       -t opendylan:latest \
       -t opendylan:latest-bullseye \
       empty

