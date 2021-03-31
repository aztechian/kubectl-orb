#!/bin/bash

build_cmd() {
    local cmd
    cmd="kubectl"

    if [[ -n $CONTEXT ]]; then
        cmd="${cmd} --context ${CONTEXT}"
    fi

    if [[ -n $NAMESPACE ]]; then
        cmd="${cmd} --namespace ${NAMESPACE}"
    fi

    eval "${cmd} -f $*"
}

apply() {
    eval "$(build_cmd "${FILE:--}")"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    apply
fi
