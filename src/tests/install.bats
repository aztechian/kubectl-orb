# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/install.sh
}

@test '1: test CPU detection' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    # export PARAM_TO="World"
    # Capture the output of our "Greet" function
    result=$(get_cpu)
    [ "$result" == "amd64" ]
}

@test '2: test Arch detection' {
    result=$(get_arch)
    [ "$result" == "linux" ]
}
