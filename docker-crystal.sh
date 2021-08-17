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

declare -a DOCKER_ARGS=("")
declare -a CRYSTAL_ARGS=("")

# Build any additional args needed for sub-commands
if [ $# -gt 0 ]; then
  case "$1" in
    play)
      PORT=`echo "$*" | grep -oP "(-p)|(\--port)\s+\K\d+" || echo 8080`
      DOCKER_ARGS+="--publish ${PORT}:${PORT}"
      CRYSTAL_ARGS+="--binding 0.0.0.0"
      ;;
  esac
fi

docker run \
    --rm \
    --tty \
    --init \
    --interactive \
    --volume `pwd`:/data \
    --workdir /data \
    ${DOCKER_ARGS} \
    crystallang/crystal:${CRYSTAL_VERSION} \
    crystal $* ${CRYSTAL_ARGS}
