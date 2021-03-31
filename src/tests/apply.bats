# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/apply.sh
}

@test '1: test command building without options' {
    result=$(build_cmd -)
    [ "$result" == "kubectl -f -" ]
}

@test '2: test command building with namespace' {
    export NAMESPACE=test1
    result=$(build_cmd -)
    [ "$result" == "kubectl --namespace test1 -f -" ]
}

@test '3: test command building with context' {
    export CONTEXT=test1
    result=$(build_cmd -)
    [ "$result" == "kubectl --context test1 -f -" ]
}

@test '4: test command building with file' {
    result=$(build_cmd test1)
    [ "$result" == "kubectl -f test1" ]
}
