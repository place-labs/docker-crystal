#!/usr/bin/env bash

set -o errexit
set -o nounset

if [ -f shard.yml ]; then
  # Naively extract the crystal version from shard.yml
  CRYSTAL_VERSION=`grep 'crystal:' shard.yml | awk '{print $2}'`
else
  (>&2 echo "Could not find shard.yml")
  CRYSTAL_VERSION="latest"
fi

(>&2 echo "⬡ Using crystal:${CRYSTAL_VERSION}")

docker run \
    --rm \
    --volume `pwd`:/data \
    --workdir /data \
    crystallang/crystal:${CRYSTAL_VERSION} \
    crystal $*
