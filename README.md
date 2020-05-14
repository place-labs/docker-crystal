# docker-crystal

![logo](docker-crystal.svg)

Shell script for running crystal via the official crystal-lang docker images.

## Installation

Get `docker-crystal.sh` (clone this repo or [download](https://raw.githubusercontent.com/place-labs/docker-crystal/master/docker-crystal.sh)).

Ensure that it's executable.
```bash
chmod +x ./docker-crystal.sh
```

Add it to you PATH
```bash
ln -s $(pwd)/docker-crystal.sh ~/bin/docker-crystal
```

## Usage

Use `docker-crystal` in the exact same way you would use the `crystal` command.

```bash
docker-crystal spec
```

```bash
docker-crystal build
```

In place of using (or even requiring) a locally installed version, it will spin up an ephemeral container.
The version used is (in order of priority) `CRYSTAL_VERSION` env var, the crystal version in `shard.yml`, or `latest`.
Any build artifacts or docs generated will appear in the local file system as though they had been built natively.
