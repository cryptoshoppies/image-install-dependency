# config

function install_docker() {
    # ---------------------------------------------------------
    # check arguments
    # ---------------------------------------------------------
    [[ -z $ARCH ]] && echo "ARCH not set. Support only linux-aarch64|linux-x86_64" && exit 1

    DOCKER_ARCH=$ARCH
    DOCKER_COMPOSE_PLUGIN=${DOCKER_COMPOSE_PLUGIN:-2.22.0}

    # install
    apt install docker -y
    apt install docker-compose -y

    # install docker-plugin
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins
    curl -SL https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_PLUGIN/docker-compose-$$DOCKER_ARCH -o $DOCKER_CONFIG/cli-plugins/docker-compose

    # set
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
}

[[ ! $HELP ]] && install_docker $@ || echo "install docker, docker-compose, docker-compose-plugin"
