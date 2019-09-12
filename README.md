# FlaskBootstrap
Generic starting point for a standard flask project

Designed for:

* Python 3.6+ 
* Linux

Run the setup to rename everything to your own project name.

```bash
python -m venv venv
source venv/bin/activate
pip install reusables

python project_setup.py
```

Create your own config file at /FlaskBootstrap/<project_name>.config.yaml 

Should contain the following items:

```yaml
env: production
host: 0.0.0.0
port: 8080 # Should match the one in <project_name>.nginx
session_secret: bad_secret  # make real one with os.urandom(32).hex()
```


Run the project:

```bash
pip install -r requirements.txt
python -m project_name
```

## Deploy for project_name

As on Ubuntu 18.04

As root:
```
apt update
apt install python3-venv python3-pip -y
mkdir /var/log/<project_name>
addgroup <project_name>
useradd -g <project_name> <project_name>


# make the three directories of the current live site (src), backup duirng deploy (backup) and staged files for deployment (staging)

mkdir -p /opt/<project_name> /opt/<project_name>/src 
# Copy project to /opt/<project_name>/src/

chown -R <project_name>:<project_name> /opt/<project_name>
sudo -u <project_name> bash -c "python3 -m venv /opt/<project_name>/venv"
sudo -u <project_name> bash -c "/opt/<project_name>/venv/bin/pip install -r /opt/<project_name>/src/requirements.txt --no-cache"

cp /opt/<project_name>/src/<project_name>.service /etc/systemd/system/<project_name>.service
chown root:root /etc/systemd/system/<project_name>.service
chmod 0755 /etc/systemd/system/<project_name>.service
systemctl daemon-reload
systemctl enable  /etc/systemd/system/<project_name>.service
systemctl start <project_name>.service

```
