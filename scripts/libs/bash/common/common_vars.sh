#!/usr/bin/env bash
__THIS_PATH="$( cd -- "$(dirname "${BASH_SOURCE}")" >/dev/null 2>&1 || exit ; pwd -P )"
__SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
__BASE_PATH="$( cd -- "${__SCRIPT_PATH}/../.." >/dev/null 2>&1 || exit ; pwd -P )"

__SCRIPT_NAME="$(basename "$0")"
__ROOT_PATH="$( cd -- "${__BASE_PATH}/.." >/dev/null 2>&1 || exit ; pwd -P )"
__BASE_DIRNAME="$( basename "${__BASE_PATH}" )"
__UTILS=${__SCRIPT_PATH}
__LIBS=${__BASE_PATH}/scripts/libs/bash
__COMMON=${__BASE_PATH}/scripts/libs/bash/common
__BUILD_DIR=${__BASE_PATH}/build

__LOCAL_USER=$(id -un)
_LOCAL_PASSWORD=
