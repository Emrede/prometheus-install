#!/bin/bash

ALERTMANAGER="alertmanager-0.22.2.linux-amd64"
ALERTMANAGERLINK="https://github.com/prometheus/alertmanager/releases/download/v0.22.2/alertmanager-0.22.2.linux-amd64.tar.gz"

cd /tmp
wget $ALERTMANAGERLINK
tar -xvzf $ALERTMANAGER.tar.gz
sudo mv $ALERTMANAGER/alertmanager /usr/local/bin/

sudo mkdir /etc/alertmanager/
sudo cp $ALERTMANAGER/alertmanager.yml /etc/alertmanager/
sudo cp $ALERTMANAGER/alert.rules.yml /etc/prometheus/

echo "### Add \" - alert.rules.yml\" entry into the prometheus.yml under \"rule_files:\" section ###"

sudo cp alertmanager.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager
sudo systemctl status alertmanager
