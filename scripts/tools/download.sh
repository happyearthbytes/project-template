#!/usr/bin/env bash
. $(dirname "${BASH_SOURCE}")/tool_common_include.sh
g_DEFAULT_ARGS=("-o" "${__BUILD_DIR}")

#==============================================================================

# Includes
. "${__LIBS}"/lib_container.sh

# Vars
_PREBUILT_CONTAINERS=(
  alpine:latest
)

_DOWNLOAD_CONTAINER_FILE_DIR=${__CONTAINER_FILE_DIR}/download-containers
_ALL_CONTAINER_DIRS=(
# ${_DOWNLOAD_CONTAINER_FILE_DIR}/os/centos7
# ${_DOWNLOAD_CONTAINER_FILE_DIR}/os/centos8
# ${_DOWNLOAD_CONTAINER_FILE_DIR}/os/rocky8
${_DOWNLOAD_CONTAINER_FILE_DIR}/os/rocky9
# ${_DOWNLOAD_CONTAINER_FILE_DIR}/web
)

_setup() {
  local select_from=(podman docker buildah echo)
  __set_container_tool $(__select_command ${select_from[@]})
}
_prepare_download_images() {
  __download_containers_from_web ${_PREBUILT_CONTAINERS[@]}
}
_build_download_images() {
  __build_container_from_dir ${_ALL_CONTAINER_DIRS[@]}
}
_save_download_images() {
  __save_container_image ${g_CONTAINER_IMAGES[@]} "${__OUTPUT_ARGS}/containers"
}

###############################################################################
# MAIN
###############################################################################
_main() {
  . "${__RUN_ARGPARSE}"
  _setup
  _prepare_download_images
  _build_download_images
  _save_download_images
} # main ######################################################################
_main