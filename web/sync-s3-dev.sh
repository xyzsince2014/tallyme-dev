#!/bin/bash

rm -rf public

aws s3 sync s3://tokyomap-front-dev public
aws s3 ls --recursive s3://tokyomap-front-dev
