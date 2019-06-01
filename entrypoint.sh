#!/bin/sh
set -e
aria2c https://github.com/game-avg/deploy-ec-server/releases/latest/downloads.txt
aria2c -c -i  downloads.txt
sha256sum -c SHASUMS256.txt
EXCODE=$?
if [ "$EXCODE" != "0" ]; then
    echo "SHASUMS256 fail"
    exit 1
fi
7z x storage.7z.001