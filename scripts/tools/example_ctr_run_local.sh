#!/usr/bin/env bash
COMMON_USER=user
COMMON_GROUP=user

function cleanup() {
  sudo chown -R ${COMMON_USER}:${COMMON_GROUP} /home/${COMMON_USER}/.local/share/containers
  sudo chown -R ${COMMON_USER}:${COMMON_GROUP} /run/user/"$(id -u ${COMMON_USER})"/containers
}
trap cleanup EXIT QUIT HUP INT TERM ABRT

ROOT_DIR="--root /home/$COMMON_USER/.local/share/containers/storage/" # force to user
ENABLE_MOUNT="--security-opt label:disable"
if [ "$(id -u)" != "0" ]; then
  ENABLE_MOUNT="--userns=keep-id --security-opt label:disable"
fi
podman "${ROOT_DIR}" run -it  "${ENABLE_MOUNT}" -v"${PWD}":/data -w/data "${@}"
