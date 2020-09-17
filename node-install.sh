#!/bin/bash

# Run without sudo
#==================#
# GLOBAL VARIABLES #
#==================#
NODE="node_exporter-1.0.1.linux-amd64"
NODELINK="https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz"

echo "#############################################################"
echo "# === Prometheus Node Exporter Installation for Ubuntu  === #"
echo "#############################################################"

loading(){
    echo -ne '#####                     (33%)\r'
    sleep 2
    echo -ne '#############             (66%)\r'
    sleep 2
    echo -ne '#######################   (100%)\r'
    sleep 1
    echo -ne '\n'
}

cd /tmp
wget $NODELINK
tar xvfz $NODE.tar.gz
sudo cp $NODE/node_exporter /usr/local/bin
node_exporter --version
sleep 2

echo "# === Systemd service is being installed ... === #"
sleep 2

cd $HOME/prometheus-node-install
sudo cp node-exporter.service /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/node-exporter.service
sudo systemctl daemon-reload
sudo systemctl start node-exporter.service

loading

echo "# === Installation completed  ! === #"
sleep 1

sudo systemctl status node-exporter.service