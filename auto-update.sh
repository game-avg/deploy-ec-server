#!/usr/bin/env bash
set -e
cp ec-server-update.service /usr/lib/systemd/system
cp ec-server-update.timer /usr/lib/systemd/system
systemctl daemon-reload
systemctl enable ec-server-update.timer
systemctl start ec-server-update.timer