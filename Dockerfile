FROM alpine:3.10

ARG TERRAFORM_VERSION="0.12.25"
ARG TERRAFORM_AWS_PROVIDER_VERSION="2.62.0"
ARG VAULT_VERSION="1.4.1"
ARG SALT_VERSION="2019.2.4-r0"
# download links and zip file names
ENV TERRAFORM_ZIP_FILE="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
ENV TERRAFORM_DOWNLOAD_LINK="https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/$TERRAFORM_ZIP_FILE"
ENV TERRAFORM_AWS_PROVIDER_ZIP_FILE="terraform-provider-aws_${TERRAFORM_AWS_PROVIDER_VERSION}_linux_amd64.zip"
ENV TERRAFORM_AWS_PROVIDER_DOWNLOAD_LINK="https://releases.hashicorp.com/terraform-provider-aws/${TERRAFORM_AWS_PROVIDER_VERSION}/${TERRAFORM_AWS_PROVIDER_ZIP_FILE}"
ENV VAULT_ZIP_FILE="vault_${VAULT_VERSION}_linux_amd64.zip"
ENV VAULT_DOWNLOAD_LINK="https://releases.hashicorp.com/vault/${VAULT_VERSION}/${VAULT_ZIP_FILE}"
# plugin locations: ~/.terraform.d/plugin or ~/.terraform.d/plugins/<OS>_<ARCH>
ENV TERRAFORM_PLUGIN_DIR="/root/.terraform.d/plugins"

RUN apk update && \
  apk add --no-cache \
  git \
  bash \
  openssh-server \
  wget \
  unzip \
  curl \
  jq \
  ca-certificates \
  go

# install python3 and upgrade pip3
RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
  apk add --no-cache --update python3 && \
  pip3 install --upgrade pip setuptools

# install the pip packages such as aws cli from the requirements file
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt && \
  rm /tmp/requirements.txt

# remove build dependencies
RUN apk del .build-deps

# install Salt and its components
RUN apk add salt-master="${SALT_VERSION}" \
  salt-minion="${SALT_VERSION}" \
  salt-api="${SALT_VERSION}" \
  salt-ssh="${SALT_VERSION}" \
  salt-cloud="${SALT_VERSION}" \
  salt-syndic="${SALT_VERSION}"

# get and mv terraform bin to /usr/local/bin
RUN wget --quiet --directory-prefix="/tmp" "${TERRAFORM_DOWNLOAD_LINK}" && \
  unzip "/tmp/${TERRAFORM_ZIP_FILE}" -d /usr/local/bin/ && \
  rm "/tmp/${TERRAFORM_ZIP_FILE}"

# get aws provider plugin
RUN mkdir -p "${TERRAFORM_PLUGIN_DIR}" && \
  wget --quiet --directory-prefix="${TERRAFORM_PLUGIN_DIR}" "${TERRAFORM_AWS_PROVIDER_DOWNLOAD_LINK}" && \
  unzip "${TERRAFORM_PLUGIN_DIR}/${TERRAFORM_AWS_PROVIDER_ZIP_FILE}" -d "${TERRAFORM_PLUGIN_DIR}" && \
  rm "${TERRAFORM_PLUGIN_DIR}/${TERRAFORM_AWS_PROVIDER_ZIP_FILE}"

# get Vault
RUN wget --quiet --directory-prefix="/tmp" "${VAULT_DOWNLOAD_LINK}" && \
  unzip "/tmp/${VAULT_ZIP_FILE}" -d /usr/local/bin/ && \
  rm "/tmp/${VAULT_ZIP_FILE}"

# uncomment for testing
#ENTRYPOINT ["/bin/sh"]
