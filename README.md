# Managing senseBox infrastructure

After cloning, run `git submodule init`. If you want to update the docker-compose submodule, run `git submodule update --remote`

This repository contains tools to provision and manage an openSenseMap instances:
- ansible playbook
- terraform configuration
- docker-compose configuration for openSenseMap
- docker image for running all of the above

You should always use `./start.sh` to run this container to ensure the files in `workdir` have the same id as your user.

The directory `workdir` can be used for your own configuration files.

