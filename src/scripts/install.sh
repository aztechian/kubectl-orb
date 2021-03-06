#!/bin/bash

if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi

get_arch() {
    uname | tr '[:upper:]' '[:lower:]'
}

get_cpu() {
    local cpu
    cpu="$(uname -m)"
    case "$cpu" in
    'x86_64') cpu="amd64" ;;
    'arm64') cpu="amd64" ;; #hack for apple silicon - use x86 with Rosetta
    'aarch64') cpu="arm64" ;;
    esac
    echo "$cpu"
}

install() {
    local platform
    platform="$(get_arch)"
    curl -s -O "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/${platform}/$(get_cpu)/kubectl"
    $SUDO mv kubectl /usr/local/bin
    $SUDO chmod 755 /usr/local/bin/kubectl
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    install
fi
