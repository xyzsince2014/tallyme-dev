#!/bin/bash
docker container run -d --rm \
  -p 443:443 \
  -p 80:80 \
  -v "$(pwd)/var/log":/var/log/nginx \
  -v "$(pwd)/public":/usr/share/nginx/html:ro \
  --name tokyomap-web \
  --net network_tokyomap \
  tokyomap.web:dev
