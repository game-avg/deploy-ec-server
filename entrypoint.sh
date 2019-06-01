#!/bin/sh
set -e
# copy files
cp -f /app/auto-update.sh /app/auto-update.sh
cp -f /app/run.sh /app/run.sh
cp -f /app/ec-server-update.service /app/ec-server-update.service
cp -f /app/ec-server-update.timer /app/ec-server-update.timer
chmod +x /app/auto-update.sh
chmod +x /app/run.sh
# download files
aria2c https://github.com/game-avg/deploy-ec-server/releases/latest/downloads.txt
aria2c -c -i  downloads.txt
# check files sha256
sha256sum -c SHASUMS256.txt
EXCODE=$?
if [ "$EXCODE" != "0" ]; then
    echo "SHASUMS256 fail"
    exit 1
fi
# Decompression
7z x storage.7z.001