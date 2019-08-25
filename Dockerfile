ARG docker_python_version=alpine

FROM python:${docker_python_version} AS install_ansible
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    make \
    musl-dev \
    openssl-dev \
    sshpass
RUN pip install ansible==2.8.4

FROM install_ansible AS decrypt_ansible_vault
ARG ansible_vault_password
COPY ansible/vars/vault.yaml /vault.yaml
RUN echo "${ansible_vault_password}" > /password.txt \
    && ansible-vault decrypt --vault-id /password.txt /vault.yaml \
    && rm /password.txt

FROM install_ansible AS install_tools
RUN apk add --no-cache \
    nano \
    zsh

FROM install_tools
LABEL maintainer="ryan.horiguchi@gmail.com"
ARG target_address
ENV TARGET_ADDRESS=${target_address}
ARG target_host_ansible_name
ENV TARGET_HOST_ANSIBLE_NAME=${target_host_ansible_name}
ARG target_host_os_model
ENV TARGET_HOST_OS_MODEL=${target_host_os_model}
COPY ansible /ansible/
RUN mkdir /etc/ansible \
    && mv /ansible/hosts.yaml /etc/ansible/hosts
COPY --from=decrypt_ansible_vault /vault.yaml /ansible/vars/vault.yaml
WORKDIR /ansible
# TODO user user /bin/
CMD ["tail", "-f", "/dev/null"]
