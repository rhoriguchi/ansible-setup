FROM python:3.8.1-alpine AS install_ansible
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    make \
    musl-dev \
    openssh \
    openssl-dev \
    sshpass
RUN pip install ansible==2.9.5

FROM install_ansible AS install_tools
RUN apk add --no-cache \
    nano \
    zsh

FROM install_tools
ARG target_address
ENV TARGET_ADDRESS=${target_address}
ARG target_host_ansible_name
ENV TARGET_HOST_ANSIBLE_NAME=${target_host_ansible_name}
ARG target_host_os_model
ENV TARGET_HOST_OS_MODEL=${target_host_os_model}
COPY ansible /ansible/
RUN mkdir /etc/ansible \
    && mv /ansible/hosts.yaml /etc/ansible/hosts
WORKDIR /ansible
CMD ["tail", "-f", "/dev/null"]
