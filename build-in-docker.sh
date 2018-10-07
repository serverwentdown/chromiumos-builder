#!/bin/sh

set -e

docker build -t cr --target sdk .
docker run --name cr -it -v $PWD/dist:/dist cr
