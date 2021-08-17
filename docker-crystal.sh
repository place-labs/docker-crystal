#!/usr/bin/env bash

set -o errexit
set -o nounset

# Get the version of Crystal to be using
if [ -v CRYSTAL_VERSION ]; then
  CRYSTAL_VERSION=${CRYSTAL_VERSION}
elif [ -f shard.yml ]; then
  # Naively extract from shard.yml
  CRYSTAL_VERSION=`grep -oP 'crystal:\s*"?\K\d+\.\d+\.\d+' shard.yml || echo "latest"`
else
  (>&2 echo "Could not find shard.yml")
  CRYSTAL_VERSION="latest"
fi
(>&2 echo "⬡ Using crystal:${CRYSTAL_VERSION}")

docker run \
    --rm \
    --tty \
    --init \
    --interactive \
    --network host \
    --volume `pwd`:/data \
    --workdir /data \
    crystallang/crystal:${CRYSTAL_VERSION} \
    crystal $*
