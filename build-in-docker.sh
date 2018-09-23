#!/bin/sh

set -e

docker build -t cr .
docker run --name cr -it -v $PWD/dist:/dist cr
