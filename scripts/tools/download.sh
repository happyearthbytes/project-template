#!/usr/bin/env bash
. $(dirname "${BASH_SOURCE}")/tool_common_include.sh
g_DEFAULT_ARGS=("-o" "${__BUILD_DIR}")
__OUTPUT_ARGS=/tmp
#==============================================================================

# Includes
. "${__LIBS}"/lib_container.sh


_setup_download() {
  local select_from=(podman docker buildah echo)
  __set_container_tool $(__select_command ${select_from[@]})
  __select_command "${select_from[@]}"
}
_prepare_download_images() {
  __download_containers_from_web "${_PREBUILT_CONTAINERS[@]}"
}
_build_download_images() {
  __build_container_from_dir "${_DOWNLOAD_PREREQS[@]}"
}
_save_download_images() {
  __save_container_image "${g_CONTAINER_IMAGES[@]}" "${__OUTPUT_ARGS}/containers"
}

# Vars
_PREBUILT_CONTAINERS=( # Common to all
  alpine:latest
)

_DOWNLOAD_CONTAINER_FILE_DIR=${__CONTAINER_FILE_DIR}/download-containers

###
# FACTORY - Implementations
###
# To support bash without associative arrays
_DOWNLOAD_PREREQS_Rocky_Linux_9=(
  ${_DOWNLOAD_CONTAINER_FILE_DIR}/os/rocky9
)
_DOWNLOAD_PREREQS_Rocky_Linux_8=(
  ${_DOWNLOAD_CONTAINER_FILE_DIR}/os/rocky8
)

###
# FACTORY - Generator
###
_register_names()
{
  local match=(Rocky_Linux_9 Rocky_Linux_8)
  local suffix=${_OS_FLAG}
  if [[ ! " ${match[@]} " =~ " ${suffix} " ]]; then
    >&2 echo "Error: Invalid environment type: ${suffix}"
    exit 1
  fi
  local var_name="_DOWNLOAD_PREREQS_${suffix}"[@]
  _DOWNLOAD_PREREQS=( "${!var_name}" )
}

###############################################################################
# FUNCTION DEFINITIONS
###############################################################################
g_argparse()
{
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --type)
        _TYPE_FLAG=$2
        shift;
        shift;
        ;;
      --os)
        _OS_FLAG=$2
        shift;
        shift;
        ;;
      *) # positional arg
        g_POSITIONAL+=("$1") # save it in an array for later
        shift;
        ;;
    esac
  done
  if [ -z "${_TYPE_FLAG}" ]; then
    local select_from=(online_deps)
    _TYPE_FLAG=$(__user_select "${select_from[@]}" "Select download type:")
    [ -z "${_TYPE_FLAG}" ] && exit 0
  fi
  if [ -z "${_OS_FLAG}" ]; then
    local select_from=("Rocky_Linux_9" "Rocky_Linux_8")
    _OS_FLAG=$(__user_select "${select_from[@]}" "Select download type:")
    [ -z "${_OS_FLAG}" ] && exit 0
  fi
}

###############################################################################
# MAIN
###############################################################################
_main() {
  source "${__RUN_ARGPARSE}"

  _register_names
  _setup_download
  _prepare_download_images
  _build_download_images
  _save_download_images
} # main ######################################################################
_main