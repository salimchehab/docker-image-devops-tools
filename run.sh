#!/bin/bash

set -e

readonly CONTAINER_IMAGE="devops-tools"
readonly TAG="1.0.0"
declare -ra bins=(
  "terraform"
  "vault"
  "aws"
  "python3.7"
  "salt"
  "ansible"
)

function build() {
  sudo docker build --tag "${CONTAINER_IMAGE}:${TAG}" .
}

function verify_versions() {
  for bin in "${bins[@]}"; do
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} "${bin}" --version
  done
  sudo docker run -i ${CONTAINER_IMAGE}:${TAG} go version
}

function main() {
  build
  verify_versions
}

main
