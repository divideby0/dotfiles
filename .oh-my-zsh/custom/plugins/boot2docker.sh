export_boot2docker() {
    export DOCKER_HOST="tcp://$(boot2docker ip 2>/dev/null):2376"
    export DOCKER_CERT_PATH="/Users/$(whoami)/.boot2docker/certs/boot2docker-vm"
    export DOCKER_TLS_VERIFY=1
}

start_boot2docker() {
    boot2docker ip 2>/dev/null >/dev/null || boot2docker up
    export_boot2docker
}

export_boot2docker