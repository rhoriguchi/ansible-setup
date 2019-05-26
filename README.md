# Ansible setup

## Default Ports

- Glances - 61208
- Home Assistant - 443
- Plex - 32400
- Plexget - 5050
- Portainer - 9000
- Resilio Sync - 8888
- SSH - 22
- Sickchill 8081
- Transmission - 9091

## Setup

Clone repo

```bash
git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup
```

Edit .env and all missing variables.

```bash
docker-compose up --detach --build
docker exec -it ansible zsh
```

### Init system

```bash
ansible-playbook init_system.yaml
```

### Setup for XXLPitu-Raspberry-Pi-Home

```bash
ansible-playbook xxlpitu-raspberry-pi-home.yaml
```

### Setup for XXLPitu-Raspberry-Pi-JCRK

```bash
ansible-playbook xxlpitu-raspberry-pi-jcrk.yaml
```

### Setup for XXLPitu-Odroid-Home

```bash
ansible-playbook xxlpitu-odroid-home.yaml
```

### Update Home Assistant version and files

```bash
ansible-playbook homeassistant_update.yaml
```

## Ansible

### Encrypt vault

```bash
ansible-vault encrypt vars/vault.yaml
```

### Show all ansible variables

```bash
ansible -m setup HOST
```

## Find PARTUUID for drives

```bash
sudo blkid | grep -i "PARTUUID="
```

## Encrypt password

```bash
mkpasswd -m sha-512 -S "SALT" -s <<< "PASSWORD"
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
