#!/usr/bin/env bash
DEFAULT_BRANCH=(develop)
BRANCH=(${@:-${DEFAULT_BRANCH[@]}})

UTILITY_DIR="$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )"
GIT_URL=`${UTILITY_DIR}/get_config_val.sh git_url`

echo "================================"
echo "-- Using"
echo "URL: ${GIT_URL}"
echo "BRANCH: ${BRANCH}"
echo "================================"
echo "-- Cloning ..."
TEMP_DIR="$( mktemp -d )"
REPO_PATH="${TEMP_DIR}/tools"
git clone ${GIT_URL} --branch ${BRANCH} ${REPO_PATH}
echo "================================"
echo "-- Reinstalling ..."
make -C ${REPO_PATH} reinstall
echo "================================"
echo "-- Removing ${TEMP_DIR} ..."
rm -rf ${REPO_PATH}
echo "================================"
echo "-- Done"
echo "================================"