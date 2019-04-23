# Ansible setup

## Default Ports

- Glances - 61208
- Home Assistant - 8123
- Plex - 32400
- Resilio Sync - 8888
- SSH - 22
- Sickchill 8081
- Tautulli - 8181

## Setup

Clone repo

```bash
git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup
```

Edit .env and enter ansible vault password and set the IP address of the host to configure.

```bash
docker-compose up --detach --build
docker exec -it ansible zsh
```

### Run in container for all

Choose value for target_host variable `raspberry` or `odroid`.

```bash
ansible-playbook init_system.yaml --extra-vars target_host=
```

### Run in container for XXLPitu-Raspberry-Pi-Home

```bash
ansible-playbook xxlpitu-raspberry-pi-home.yaml
```

### Run in container for XXLPitu-Raspberry-Pi-JCRK

```bash
ansible-playbook xxlpitu-raspberry-pi-jcrk.yaml
```

### Run in container for XXLPitu-Odroid-Home

```bash
ansible-playbook xxlpitu-odroid-home.yaml
```

## Ansible

### Encrypt vault

```bash
ansible-vault encrypt vault.dist.yaml
```

### Show all ansible variables

```bash
ansible -m setup HOST
```

## Find PARTUUID for drives

```bash
sudo blkid | grep -i "PARTUUID="
```

## Home Assistant

### Update Home Assistant version and files

```bash
git clone https://github.com/rhoriguchi/ansible_setup.git /tmp/ansible_setup

docker-compose up --detach --build
docker exec -it ansible zsh
 
ansible-playbook homeassistant_update.yaml --extra-vars target_host=TARGET_HOST
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
