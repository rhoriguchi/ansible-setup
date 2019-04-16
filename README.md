# Ansible setup

## Requirements

### Ansible
Python >= 3.5

## Default Ports

- SSH - 22
- Home Assistant - 8123
- Tautulli - 8181
- Resilio Sync - 8888
- Plex - 32400
- Glances - 61208
- Glances client - 61209

## Setup

### Update system and install Ansible requirements

```bash
sudo apt update -y \
  && sudo apt upgrade -y \
  && sudo apt full-upgrade -y \
  && sudo apt install -y git libffi-dev python3 python3-apt python3-pip rsync \
  && sudo apt autoremove -y \
  && sudo pip3 install ansible==2.7.10

git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup
git clone https://github.com/rhoriguchi/ansible_setup_secrets.git /tmp/ansible_setup/ansible/ansible_setup_secrets
cd /tmp/ansible_setup/ansible
```

### Run for XXLPitu-Raspberry-Pi-Home

```bash
sudo ansible-playbook xxlpitu-raspberry-pi-home.yaml
```

### Run for XXLPitu-Raspberry-Pi-JCRK

```bash
sudo ansible-playbook xxlpitu-raspberry-pi-jcrk.yaml
```

### Run for XXLPitu-Odroid-Home

```bash
sudo ansible-playbook xxlpitu-odroid-home.yaml
```

### After successful setup delete OS default user

Switch to newly create user and run playbook

```bash
sudo ansible-playbook delete_os_default_user.yaml
```

## Find PARTUUID for drives

```bash
sudo blkid | grep -i "PARTUUID="
```

## Home Assistant

### Update Home Assistant version and files

```bash
git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup
git clone https://github.com/rhoriguchi/ansible_setup_secrets.git /tmp/ansible_setup/ansible/ansible_setup_secrets
cd /tmp/ansible_setup/ansible

sudo ansible-playbook homeassistant_update.yaml
```

## Encrypt password

```bash
mkpasswd  -m sha-512 -S "SALT" -s <<< "PASSWORD"
```

## USB boot Raspberry

[Instructions](ressources/USB_boot_raspberry.md)

## Harddrive

### If superblock can't be read

```bash
sudo fsck /dev/sda1
```

### Format drive

[Instructions](ressources/Format_drive.md)
