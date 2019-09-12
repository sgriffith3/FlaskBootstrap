#!/usr/bin/env bash
set -e
apt update
apt install python3-venv python3-pip -y
mkdir /var/log/<project_name>
addgroup <project_name>
useradd -g <project_name> <project_name>

# make the directories of the current live site (src)

mkdir -p /opt/<project_name> /opt/<project_name>/src 
# Copy project to /opt/<project_name>/src/
cp -r * /opt/<project_name>/src
cp requirements.txt /opt/<project_name>/
cp <project_name>.logging.yaml /opt/<project_name>/

chown -R <project_name>:<project_name> /opt/<project_name>
sudo -u <project_name> bash -c "python3 -m venv /opt/<project_name>/venv"
sudo -u <project_name> bash -c "/opt/<project_name>/venv/bin/pip install -r /opt/<project_name>/src/requirements.txt --no-cache"

cp <project_name>.service /etc/systemd/system/<project_name>.service
chown root:root /etc/systemd/system/<project_name>.service
chmod 0755 /etc/systemd/system/<project_name>.service
systemctl daemon-reload
systemctl enable  /etc/systemd/system/<project_name>.service
systemctl start <project_name>.service
