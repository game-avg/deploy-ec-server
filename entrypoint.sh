#!/bin/sh
set -e
# copy files
cp -f /app/README.md /work/README.md
cp -f /app/auto-update.sh /work/auto-update.sh
cp -f /app/run.sh /work/run.sh
cp -f /app/ec-server-update.service /work/ec-server-update.service
cp -f /app/ec-server-update.timer /work/ec-server-update.timer
cd /work
chmod +x /app/auto-update.sh
chmod +x /app/run.sh
# download files
aria2c -c --console-log-level=error --download-result=full https://github.com/game-avg/deploy-ec-server/releases/download/files/downloads.txt
aria2c -c --console-log-level=error --download-result=full -i downloads.txt
# check files sha256sum
sha256sum -c SHASUMS256.txt
# Decompression
7z x storage.7z.001