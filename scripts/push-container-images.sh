#!/bin/bash
set -ex

version=$(git describe --always --tags)

docker push orangesys/${CIRCLE_PROJECT_REPONAME}:${version}
docker images