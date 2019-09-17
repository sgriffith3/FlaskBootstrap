#!/usr/bin/env bash
set -e
apt update
apt install python3-venv python3-pip -y
mkdir /var/log/nodifyer
addgroup nodifyer
useradd -g nodifyer nodifyer

# make the directories of the current live site (src)

mkdir -p /opt/nodifyer /opt/nodifyer/src 
# Copy project to /opt/nodifyer/src/
cp -r * /opt/nodifyer/src
cp requirements.txt /opt/nodifyer/
cp nodifyer.logging.yaml /opt/nodifyer/

chown -R nodifyer:nodifyer /opt/nodifyer
sudo -u nodifyer bash -c "python3 -m venv /opt/nodifyer/venv"
sudo -u nodifyer bash -c "/opt/nodifyer/venv/bin/pip install -r /opt/nodifyer/src/requirements.txt --no-cache"

cp nodifyer.service /etc/systemd/system/nodifyer.service
chown root:root /etc/systemd/system/nodifyer.service
chmod 0755 /etc/systemd/system/nodifyer.service
systemctl daemon-reload
systemctl enable  /etc/systemd/system/nodifyer.service
systemctl start nodifyer.service
