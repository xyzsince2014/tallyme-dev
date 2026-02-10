#!/bin/bash
docker container run -d --rm \
  -p 5432:5432 \
  -v $(pwd)/hgsql/data:/var/lib/hgsql/data \
  -v $(pwd)/initdb.d:/docker-entrypoint-initdb.d \
  -v $(pwd)/var/lib/postgresql/data:/var/lib/postgresql/data \
  -v $(pwd)/var/tmp:/var/tmp \
  --name postgres \
  --network network_tokyomap \
  tokyomap.postgres:dev
