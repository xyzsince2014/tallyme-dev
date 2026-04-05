# tokyomap-dev

<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/xyzsince2014/tokyomap-dev">
<img alt="GitHub tag (latest by date)" src="https://img.shields.io/github/v/tag/xyzsince2014/tokyomap-dev">

Dev environment for https://www.tokyomap.live, accessible by https://localhost.

## How to dev
```bash
# docker network
./docker-create-network.sh

# postgres
cd postgres
./docker-build.sh
./docker-run.sh

# redis
cd redis
./docker-run.sh

# web
cd web
./sync-s3-dev.sh
# Generate self-signed SSL certs for localhost HTTPS (required before building the image)
./certs/certbot.sh
./docker-build.sh
./docker-run.sh

# run other docker containers
## see
## https://github.com/xyzsince2014/tokyomap-oauth
## https://github.com/xyzsince2014/tokyomap-resource
## https://github.com/xyzsince2014/tokyomap-app
```
