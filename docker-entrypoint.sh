#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u "$USER_ID" -o -c "" -m user
export HOME=/home/user
echo "PS1='Active machine:\[\e[1m\]\[\e[31m\]\$(__docker_machine_ps1 \" %s\")\[\e[m\]\[\e[0m\]\n \[\e[1m\]\[\e[36m\]\w\[\e[m\] \[\e[32m\]\$\[\e[m\]\[\e[0m\] '" >> /home/user/.bashrc

# symlink /workdir/ssh_config to /etc/ssh/ssh_config if it exits
if [ -f /workdir/ssh_config ]; then
  mv /etc/ssh/ssh_config /etc/ssh/ssh_config.bkp
  ln -s /workdir/ssh_config /etc/ssh/ssh_config
fi

# symlink /workdir/docker_config.json to ~/.docker/config.json if it exits
if [ -f /workdir/docker_config.json ]; then
  mkdir -p "$HOME/.docker"
  ln -s /workdir/docker_config.json "$HOME/.docker/config.json"
fi

chown -R user /workdir /infrastructure

exec /usr/local/bin/gosu user "$@"
