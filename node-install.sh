#!/bin/bash

echo "#############################################################"
echo "# === Prometheus Node Exporter Installation for Ubuntu  === #"
echo "#############################################################"

cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.0.1.linux-amd64.tar.gz
sudo cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin
node_exporter --version
sleep 1

echo "# === Systemd service is being installed ... === #"
sleep 1

sudo cp node-exporter.service /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/node-exporter.service
sudo systemctl daemon-reload
sudo systemctl start node-exporter.service
# sudo systemctl status node-exporter.service

echo "# === Installation completed  ! === #"
