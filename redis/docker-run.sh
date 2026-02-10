#!/bin/bash
docker container run -d --rm \
  -v $(pwd)/data:/data \
  --name redis \
  --network network_tokyomap \
  redis:7-alpine
