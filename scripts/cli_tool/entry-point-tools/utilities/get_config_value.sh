#!/usr/bin/env bash
DATA_DIR="$(realpath $( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )/../data)"
CONFIG_FILE=${DATA_DIR}/config.yml

DEFAULT_KEY="none"
KEY=(${1:-${DEFAULT_KEY}})

VAL=$(sed -n '/^'${KEY}':/ s/[^:]*: *//p' ${CONFIG_FILE})
echo ${VAL}