#!/bin/bash

WORKDIR="$(pwd)/workdir"

echo "updating workdir ..."

git -C workdir pull origin master

docker-compose run --rm -e LOCAL_USER_ID="$(id -u $USER)" cloudmanager

# The command list all changed files, the if checks if the string is empty
if [[ -n "$(git -C ${WORKDIR} ls-files -m -o -d)" ]]; then
  echo "Changes to the workdir detected!"
  echo "git -C ${WORKDIR} status"
  git -C "${WORKDIR}" status

  echo ""
  echo "(^C to abort)"
  echo "Please enter a commit message and press enter to add (git add -A), commit (git commit -m \"YOUR MESSAGE\") and push (git push origin master) your changes."
  echo -n " > "
  read msg
  while [[ -z "${msg}" ]]; do
    echo "(^C to abort)"
    echo "Please enter a commit message and press enter to add (git add -A), commit (git commit -m \"YOUR MESSAGE\") and push (git push origin master) your changes."
    echo -n " > "
    read msg
  done

  echo "git -C ${WORKDIR} add -A"
  git -C "${WORKDIR}" add -A

  echo "git -C ${WORKDIR} commit -m \"${msg}\""
  git -C "${WORKDIR}" commit -m "${msg}"

  echo "git -C ${WORKDIR} push origin master"
  git -C "${WORKDIR}" push origin master
fi
