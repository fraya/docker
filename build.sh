#!/bin/bash

docker build -f Dockerfile.opendylan-release --network host -t opendylan:release .
docker build -f Dockerfile.opendylan-current --network host -t opendylan:current -t opendylan:latest .

