FROM buildpack-deps:stretch-scm

ENV DOCKER_MACHINE_VERSION=0.12.0 \
  DOCKER_COMPOSE_VERSION=1.14.0 \
  TERRAFORM_VERSION=0.9.8 \
  MACHINE_STORAGE_PATH=/cloudmanager/docker-machine_storage \
  TERM=xterm-256color

# installs
# docker-machine
# docker-compose
# terraform
# ansible
# bash-completion
# gosu
# vim
# tmux
# openconnect
RUN apt-get update && apt-get install -y vim tmux openconnect unzip bash-completion libffi-dev libssl-dev python-dev python-pip python-setuptools build-essential --no-install-recommends && \
  rm -rf /var/lib/apt/lists/* && \
  curl -L https://github.com/docker/machine/releases/download/v$DOCKER_MACHINE_VERSION/docker-machine-Linux-x86_64 > /usr/local/bin/docker-machine && \
  chmod +x /usr/local/bin/docker-machine && \
  curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose && \
  curl -L -o terraform.zip https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform.zip terraform -d /usr/local/bin && \
  rm -rf terraform.zip && \
  pip install ansible && \
  apt-get purge -y --auto-remove unzip build-essential && \
  curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/engine/contrib/completion/bash/docker > /etc/bash_completion.d/docker && \
  curl -L https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine && \
  curl -L https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper && \
  curl -L https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt && \
  echo "PS1='\u@\h \w\$(__docker_machine_ps1 " [%s]") \$ '" > /etc/profile.d/docker-machine-ps1.sh && \
  curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
  chmod +x /usr/local/bin/gosu && \
  mkdir -p /docker-entrypoint.d

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /cloudmanager

VOLUME ["/cloudmanager"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/bin/bash", "--login"]
