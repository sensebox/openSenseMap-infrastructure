#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p snapshots

cp -r workdir snapshots/workdir_$(date -u --iso-8601=second)
