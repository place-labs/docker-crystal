#!/usr/bin/env bash

set -o errexit
set -o nounset

# Naively extract the crystal version from shard.yml
CRYSTAL_VERSION=`grep 'crystal:' shard.yml | awk '{print $2}'`

docker run \
    --rm \
    --volume `pwd`:/data \
    --workdir /data \
    crystallang/crystal:${CRYSTAL_VERSION} \
    crystal $*
