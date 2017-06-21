#!/bin/bash

docker-compose run --rm -e LOCAL_USER_ID="$(id -u $USER)" cloudmanager
