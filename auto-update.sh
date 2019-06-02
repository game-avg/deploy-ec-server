#!/usr/bin/env bash
set -e
if [[ ! -d "/usr/lib/systemd/system" ]]; then
  cp ec-server-update.service /usr/lib/systemd/system
  cp ec-server-update.timer /usr/lib/systemd/system
else
  cp ec-server-update.service /lib/systemd/system/
  cp ec-server-update.timer /lib/systemd/system/
fi

systemctl daemon-reload
systemctl enable ec-server-update.timer
systemctl start ec-server-update.timer