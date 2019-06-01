#!/usr/bin/env bash
docker pull ystyle/ec-uploadserver:latest
docker stop ec-uploadserver
docker rm ec-uploadserver
docker run -d --restart always \
  --name ec-uploadserver \
  -e "HTTP_BODY_LIMIT=50M" \
  -e "TOKEN=admin123" \
  -e "USERNAME=admin" \
  -e "PASSWORD=admin123" \
  -p 1321:1321 \
  -v "$PWD/storage":/app/storage \
  ystyle/ec-uploadserver
