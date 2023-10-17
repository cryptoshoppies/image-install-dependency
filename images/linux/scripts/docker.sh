# config

function execute {
    # ---------------------------------------------------------
    # check arguments
    # ---------------------------------------------------------
    [[ -z $ARCH ]] && echo "ARCH not set. Support only linux-aarch64|linux-x86_64" && exit 1

    DOCKER_ARCH=$ARCH
    DOCKER_COMPOSE_PLUGIN=${DOCKER_COMPOSE_PLUGIN:-2.22.0}

    # install
    apt install docker -y
    apt install docker-compose -y

    command install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt install docker-buildx-plugin docker-compose-plugin -y
    # apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    # # install docker-plugin
    # DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    # mkdir -p $DOCKER_CONFIG/cli-plugins
    # curl -SL https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_PLUGIN/docker-compose-$DOCKER_ARCH -o $DOCKER_CONFIG/cli-plugins/docker-compose

    # # set
    # chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
}

function help {
    echo "install docker, docker-compose, docker-compose-plugin"
}
