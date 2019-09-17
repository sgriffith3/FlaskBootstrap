# FlaskBootstrap
Generic starting point for a standard flask project

Designed for:

* Python 3.6+ 
* Linux

Run the setup to rename everything to your own project name.

```bash
sudo apt-get install python3-venv
python3 -m venv venv
source venv/bin/activate
pip3 install reusables
python3 project_setup.py
```

### PUT YOUR CODE IN NOW!
### It goes in nodifyer/views/templated.py
### Massage it in to existing code
### Yes, I mean manually
### Yes, I am sure
### DON"T GO PAST THIS POINT WITHOUT ADDING YOUR CODE

Deploy your project as a daemon and start the service

```bash
chmod +x deploy.sh
sudo ./deploy.sh
```

## Deploy for nodifyer

As on Ubuntu 18.04

This is the deploy.sh file

As root:
```
apt update
apt install python3-venv python3-pip -y
mkdir /var/log/nodifyer
addgroup nodifyer
useradd -g nodifyer nodifyer


# make the three directories of the current live site (src), backup duirng deploy (backup) and staged files for deployment (staging)

mkdir -p /opt/nodifyer /opt/nodifyer/src 
# Copy project to /opt/nodifyer/src/

chown -R nodifyer:nodifyer /opt/nodifyer
sudo -u nodifyer bash -c "python3 -m venv /opt/nodifyer/venv"
sudo -u nodifyer bash -c "/opt/nodifyer/venv/bin/pip install -r /opt/nodifyer/src/requirements.txt --no-cache"

cp /opt/nodifyer/src/nodifyer.service /etc/systemd/system/nodifyer.service
chown root:root /etc/systemd/system/nodifyer.service
chmod 0755 /etc/systemd/system/nodifyer.service
systemctl daemon-reload
systemctl enable  /etc/systemd/system/nodifyer.service
systemctl start nodifyer.service

```
