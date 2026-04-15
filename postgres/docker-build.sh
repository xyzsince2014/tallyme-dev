#!/bin/bash

# common defensive idiom
set -euo pipefail

export DOCKER_BUILDKIT=0

cd "$(dirname "$0")"

# Execute Docker build inside the Minikube environment
eval $(minikube docker-env)

docker build -t tallyme-postgres:dev .
