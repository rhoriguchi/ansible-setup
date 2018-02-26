# Raspbian setup

## Requirements

### Home Assistant
Python 3.5.3

### Ansible
Python 3.5

## Setup

Install Ansible requirements
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

sudo apt-get install ansible aptitude build-essential git python python-apt python-dev python-pip python3 python3-apt python3-pip python3-venv

sudo apt-get autoremove

sudo pip install --upgrade pip virtualenv virtualenvwrapper wheel
sudo pip3 install ansible==2.5.4
```

```bash
git clone https://github.com/rhoriguchi/raspbian_setup.git /tmp/raspbian_setup
cd /tmp/raspbian_setup/ansible
```

Change `****` in `/tmp/raspbian_setup/ansible/vars/default.yaml`
```bash
nano /tmp/raspbian_setup/ansible/vars/default.yaml
```

**Run for xxlpitu-home.yaml**
```bash
sudo ansible-playbook xxlpitu-home.yaml
```

Once xxlpitu-home.yaml is finish manually login to resilio sync web ui and configure.

Enable Bluetooth LE scan as non root
```bash
sudo setcap 'cap_net_raw,cap_net_admin+eip' `readlink -f \`which python3\``
```

Generate new rsa key for SSH tunnels and add it to authorized_keys in dotfiles repo and add private key to `/home/homeassistant/.ssh/id_rsa`. The private key has to be in the openssh format.

Change permissions of id_rsa to 600.
```bash
chmod 600 /home/homeassistant/.ssh/id_rsa
```

**Run for xxlpitu-jcrk.yaml**
```bash
sudo ansible-playbook xxlpitu-jcrk.yaml
```

Once xxlpitu-home.yaml is finish manually login to resilio sync and plex web ui and configure.

**After successful setup run delete_pre_installed_user.yaml**
```bash
sudo ansible-playbook delete_pre_installed_user.yaml
```

## Find PARTUUID for drives

```bash
sudo blkid | grep -i "PARTUUID="
```

## Generate Password for Ansible in user module

```bash
mkpasswd --method=sha-512 PASSWORD
```

## Find Sensirio SHT31 sensor MAC address

```bash
sudo bluetoothctl

agent on
default-agent
scan on
```

Search for device "Smart Humigadget" and get MAC address

`[NEW] Device CA:9C:5B:82:0A:22 Smart Humigadget`

```bash
scan off
exit
```

## Static IP
- Raspberry - 192.168.2.150
- Hue Bridge - 192.168.2.151
- Xiaomi Mi Bedside Lamp - 192.168.2.152

## Default Ports
- SSH - 22
- Home Assistant - 8123
- Resilio Sync - 8888
- Plex - 32400
- Glances - 61208

## Home Assistant

### secrets.yaml template
```yml
asuswrt_password: ****
asuswrt_username: ****
darksky_api_key: ****
homeassistant_elevation: ****
homeassistant_latitude: ****
homeassistant_longitude: ****
http_api_password: ****
hue_token: ****
jcrk_synology_password: ****
jcrk_synology_username: ****
lametric_client_id: ****
lametric_client_secret: ****
openweathermap_api_key: ****
telegram_bot_api_key: ****
```

### Update Home Assistant files

```bash
git clone https://github.com/rhoriguchi/raspbian_setup.git /tmp/raspbian_setup
cd /tmp/raspbian_setup/ansible

sudo ansible-playbook homeassistant_update_files.yaml
```

### Start Home Assistant

```bash
sudo systemctl start home-assistant@homeassistant
```

### Stop Home Assistant

```bash
sudo systemctl stop home-assistant@homeassistant
```

### Restart Home Assistant

```bash
sudo systemctl restart home-assistant@homeassistant
```

### Upgrade Home Assistant

```bash
sudo su -s /bin/bash homeassistant
source /srv/homeassistant/bin/activate

pip3 install --upgrade homeassistant
```

## Harddrive

### If superblock can't be read

```bash
sudo fsck /dev/sda1
```
### Format drive

![Format drive](Format_drive.png?raw=true "Title")
