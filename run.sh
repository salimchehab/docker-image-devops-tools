#!/bin/bash

set -e

readonly CONTAINER_IMAGE=devops-tools
readonly TAG="1.0.0"

function build() {
    sudo docker build --tag "${CONTAINER_IMAGE}:${TAG}" .
}

function verify_versions() {
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} terraform --version
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} vault --version
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} aws --version
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} python3.7 --version
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} salt --version
    sudo docker run -i ${CONTAINER_IMAGE}:${TAG} ansible --version
}

function main() {
    build
    verify_versions
}

main
