FROM buildpack-deps:stretch-scm

ENV DOCKER_MACHINE_VERSION=0.16.0 \
  DOCKER_COMPOSE_VERSION=1.23.1 \
  DOCKER_VERSION=18.06.1 \
  TERRAFORM_VERSION=0.12.8 \
  ANSIBLE_VERSION=2.5.5 \
  PACKER_VERSION=1.2.2 \
  MACHINE_STORAGE_PATH=/workdir/docker-machine_storage \
  TERM=xterm-256color \
  SHELL=/bin/bash

# set up locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales vim tmux bash-completion nano less --no-install-recommends && \
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=en_US.UTF-8 && \
  rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8

# installs
# docker
# docker-machine
# docker-compose
# terraform
# ansible
# packer
# bash-completion
# gosu
# vim
# tmux
RUN curl -L https://github.com/docker/machine/releases/download/v$DOCKER_MACHINE_VERSION/docker-machine-Linux-x86_64 > /usr/local/bin/docker-machine && \
  chmod +x /usr/local/bin/docker-machine

RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

RUN apt-get update && apt-get install -y unzip --no-install-recommends && \
  curl -L -o terraform.zip https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  curl -L -o packer.zip https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_${PACKER_VERSION}_linux_amd64.zip && \
  unzip terraform.zip terraform -d /usr/local/bin && \
  unzip packer.zip packer -d /usr/local/bin && \
  rm -rf terraform.zip && \
  rm -rf packer.zip && \
  apt-get purge -y --auto-remove unzip && \
  rm -rf /var/lib/apt/lists/*

RUN curl -LO https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION-ce.tgz && \
  tar --strip-components=1 -xvzf docker-$DOCKER_VERSION-ce.tgz -C /usr/local/bin && \
  rm docker-$DOCKER_VERSION-ce.tgz

#RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list && \
#  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && \
#  apt-get update && \
#  apt-get install -y ansible && \
#  rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libffi-dev libssl-dev python-dev python-pip python-setuptools build-essential --no-install-recommends && \
  pip install wheel && \
  pip install ansible==$ANSIBLE_VERSION && \
  apt-get purge -y --auto-remove build-essential && \
  rm -rf /var/lib/apt/lists/*

RUN curl -L https://raw.githubusercontent.com/docker/cli/26a2a459679f9cf367d8cca37c26601ec45fa9a7/contrib/completion/bash/docker > /etc/bash_completion.d/docker
RUN curl -L https://raw.githubusercontent.com/docker/machine/cf9d44d45ae7f99fbe3fa0320da6858ccc8f4e30/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine
RUN curl -L https://raw.githubusercontent.com/docker/machine/464e19ba1cf83cc1babb30eff3ecde24b2e79567/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper
RUN curl -L https://raw.githubusercontent.com/docker/machine/5707b38a9ef35a21f55b1390f4ac476c3d4b84e1/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt

RUN curl -o /usr/local/bin/gosu -L "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
  chmod +x /usr/local/bin/gosu

WORKDIR /workdir

VOLUME ["/workdir"]

COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash", "--login"]
