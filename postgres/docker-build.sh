#!/bin/bash
docker image rm tokyomap.postgres:dev
docker build -t tokyomap.postgres:dev .
