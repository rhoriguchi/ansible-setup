# Raspbian setup

## Requirements

### Home Assistant
Python >= 3.5.3

### Ansible
Python >= 3.5

## Default Ports

- SSH - 22
- Home Assistant - 8123
- Tautulli - 8181
- Resilio Sync - 8888
- Plex - 32400
- Glances - 61208

## Setup

Install Ansible requirements

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

sudo apt-get install ansible aptitude build-essential git python python-apt python-dev python-pip python3 python3-apt python3-pip python3-venv rsync

sudo apt-get autoremove

sudo pip install --upgrade pip virtualenv virtualenvwrapper wheel
sudo pip3 install ansible==2.5.4

git clone https://github.com/rhoriguchi/raspbian_setup.git /tmp/raspbian_setup
cd /tmp/raspbian_setup/ansible
```

Change `****` in `/tmp/raspbian_setup/ansible/vars/default.yaml`

```bash
nano /tmp/raspbian_setup/ansible/vars/default.yaml
```

### Run for xxlpitu-home.yaml

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

### Run for xxlpitu-jcrk.yaml

```bash
sudo ansible-playbook xxlpitu-jcrk.yaml
```

Once xxlpitu-home.yaml is finish manually login to resilio sync and plex web ui and configure.

### After successful setup run delete_pre_installed_user.yaml

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

## Home Assistant

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
sudo su homeassistant
source /usr/local/virtualenv/homeassistant/bin/activate

pip3 install --upgrade homeassistant
```

## Generate rsa key

### Command

Move ssh key to remote xxlpitu@xxlpitu-jcrk.duckdns.org

```bash
sudo su homeassistant
cat /home/homeassistant/.ssh/id_rsa.pub | ssh xxlpitu@xxlpitu-jcrk.duckdns.org "mkdir -p ~/.ssh && cat >> /home/xxlpitu/.ssh/authorized_keys"
```

On xxlpitu-jcrk.duckdns.org change permission of authorized_keys when updated

```bash
sudo chmod 600 -R /home/xxlpitu/.ssh/authorized_keys
```

## Harddrive

### If superblock can't be read

```bash
sudo fsck /dev/sda1
```

### Format drive

![Format drive](images/Format_drive.png?raw=true)
