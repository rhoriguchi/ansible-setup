ARG docker_python_version=alpine

FROM python:${docker_python_version} as install_ansible
ARG ansible_verion=2.7.10
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    make \
    musl-dev \
    openssl-dev
RUN pip install ansible==${ansible_verion}
# workaround for paramiko warning
RUN sed -i "/__metaclass__ = type/a import warnings\nwarnings.filterwarnings(action='ignore',module='.*paramiko.*')" /usr/local/bin/ansible-playbook

FROM install_ansible as install_tools
RUN apk add --no-cache \
    nano \
    zsh

FROM install_tools as decrypt_ansible_vault
ARG ansible_vault_password
COPY ansible/vars/vault.yaml /vault.yaml
RUN echo "${ansible_vault_password}" > /password.txt \
    && ansible-vault decrypt --vault-id /password.txt /vault.yaml \
    && rm /password.txt

FROM install_tools
LABEL maintainer="ryan.horiguchi@gmail.com"
ARG target_address
ENV TARGET_ADDRESS=${target_address}
COPY ansible /ansible/
RUN mkdir /etc/ansible \
    && mv /ansible/hosts.yaml /etc/ansible/hosts
COPY --from=decrypt_ansible_vault /vault.yaml /ansible/vars/vault.yaml
WORKDIR /ansible
CMD tail -f /dev/null
