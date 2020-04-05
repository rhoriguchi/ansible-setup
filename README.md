# Ansible setup

## Default Ports

- Glances - 61208
- ~~Home Assistant - 443~~
- Plex - 32400
- Portainer - 9000
- Price Tracker - 80/443
- Resilio Sync - 8888
- SSH - 22
- Tautulli - 8181

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

Create vault_password.txt file

```bash
echo "VAULT_PASSWORD" > vault_password.txt
```

### Init wifi

```bash
ansible-playbook --vault-password-file vault_password.txt init_wifi.yaml
```

### Init system

```bash
ansible-playbook --vault-password-file vault_password.txt init_system.yaml
```

### Setup for XXLPitu JCRK

```bash
ansible-playbook --vault-password-file vault_password.txt xxlpitu-jcrk.yaml
```

### Setup for XXLPitu Home

```bash
ansible-playbook --vault-password-file vault_password.txt xxlpitu-home.yaml
```

### Update Home Assistant version and files

```bash
ansible-playbook --vault-password-file vault_password.txt homeassistant_update.yaml
```

## Ansible

### Vault

#### Encrypt

```bash
ansible-vault encrypt --vault-password-file vault_password.txt vars/vault.yaml
```

#### Decrypt

```bash
ansible-vault decrypt --vault-password-file vault_password.txt vars/vault.yaml
```

#### Edit

```bash
ansible-vault edit --vault-password-file vault_password.txt vars/vault.yaml
```

### Show all variables

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
