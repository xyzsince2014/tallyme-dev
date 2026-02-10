#!/bin/bash

docker network create \
  --driver bridge \
  --subnet 172.20.0.0/24 \
  --gateway 172.20.0.1 \
  network_tokyomap

docker network ls | grep network_tokyomap
