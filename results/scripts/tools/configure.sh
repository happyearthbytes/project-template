#!/usr/bin/env bash
# This script configures your environment in preparation for setup
THIS_DIR="$(realpath $( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P ))"
source ${THIS_DIR}/../util/common.sh

echo "Update the file: config.yml"
echo "Update the file: env.yml"