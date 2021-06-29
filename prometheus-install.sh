#!/bin/bash

# Run without sudo
#=====# Uncomment if needed (for CentOS) ==============#
sudo yum install wget -y
# sudo yum install git -y
#======================================================#

#==================#
# GLOBAL VARIABLES #
#==================#
PROMETHEUS="prometheus-2.28.0.linux-amd64"
PROMETHEUSLINK="https://github.com/prometheus/prometheus/releases/download/v2.28.0/"$PROMETHEUS".tar.gz"

echo "# === Preparing necessary directories ... === #"
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

echo "# === Downloading files ... === #"
cd /tmp
wget $PROMETHEUSLINK #--no-check-certificate
tar -xvzf $PROMETHEUS".tar.gz"
sudo mv $PROMETHEUS prometheuspackage

echo "# === Copying files ... === #"
sudo cp prometheuspackage/prometheus /usr/local/bin/
sudo cp prometheuspackage/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

sudo cp -r prometheuspackage/consoles /etc/prometheus
sudo cp -r prometheuspackage/console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

sudo cp prometheuspackage/prometheus.yml /etc/prometheus/
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

echo "# === Configuring Prometheus service ... === #"
cd $HOME/prometheus-install
sudo cp prometheus.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus

echo "# === Firewall exception is being configured ... === #"
sudo firewall-cmd --zone=public --add-port=9090/tcp --permanent
sudo systemctl reload firewalld

echo "# === Installation completed ! === #"
