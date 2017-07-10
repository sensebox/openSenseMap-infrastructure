FROM buildpack-deps:stretch-scm

ENV DOCKER_MACHINE_VERSION=0.12.1 \
  DOCKER_COMPOSE_VERSION=1.14.0 \
  DOCKER_VERSION=17.05.0 \
  TERRAFORM_VERSION=0.9.11 \
  MACHINE_STORAGE_PATH=/workdir/docker-machine_storage \
  TERM=xterm-256color \
  SHELL=/bin/bash

# installs
# docker
# docker-machine
# docker-compose
# terraform
# ansible
# bash-completion
# gosu
# vim
# tmux
RUN apt-get update && apt-get install -y vim tmux unzip bash-completion libffi-dev libssl-dev python-dev python-pip python-setuptools build-essential --no-install-recommends && \
  rm -rf /var/lib/apt/lists/* && \
  curl -L https://github.com/docker/machine/releases/download/v$DOCKER_MACHINE_VERSION/docker-machine-Linux-x86_64 > /usr/local/bin/docker-machine && \
  chmod +x /usr/local/bin/docker-machine && \
  curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose && \
  curl -L -o terraform.zip https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform.zip terraform -d /usr/local/bin && \
  rm -rf terraform.zip && \
  curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION-ce.tgz && \
  tar --strip-components=1 -xvzf docker-$DOCKER_VERSION-ce.tgz -C /usr/local/bin && \
  rm docker-$DOCKER_VERSION-ce.tgz && \
  pip install ansible && \
  apt-get purge -y --auto-remove unzip build-essential && \
  curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/engine/contrib/completion/bash/docker > /etc/bash_completion.d/docker && \
  curl -L https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine && \
  curl -L https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper && \
  curl -L https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt && \
  curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
  chmod +x /usr/local/bin/gosu

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /workdir

VOLUME ["/workdir"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/bin/bash", "--login"]
