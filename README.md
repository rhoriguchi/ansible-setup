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

### Update Raspberry and install Ansible requirements

```bash
sudo apt update -y \
  && sudo apt upgrade -y \
  && sudo apt full-upgrade -y \
  && sudo apt install -y git python3 python3-apt python3-pip rsync \
  && sudo apt autoremove -y \
  && sudo pip3 install ansible==2.7.8

git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup
git clone https://github.com/rhoriguchi/ansible_setup_secrets.git /tmp/ansible_setup/ansible/ansible_setup_secrets
cd /tmp/ansible_setup/ansible
```

### Run for xxlpitu-home.yaml

```bash
sudo ansible-playbook xxlpitu-home.yaml
```
Once xxlpitu-home.yaml is finish manually login to resilio sync web ui and configure.

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

## Home Assistant

### Update Home Assistant version and files

```bash
git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup
cd /tmp/ansible_setup/ansible

git clone https://github.com/rhoriguchi/ansible_setup_secrets.git

sudo ansible-playbook homeassistant_update.yaml
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
