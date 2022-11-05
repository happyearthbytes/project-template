#!/usr/bin/env bash
. $(dirname "${BASH_SOURCE}")/tool_common_include.sh
g_DEFAULT_ARGS=("-i" "${__BUILD_DIR}/containers" "-o" "${__BUILD_DIR}")
#==============================================================================

# Includes
. ${__LIBS}/lib_container.sh
. ${__LIBS}/lib_package_management.sh

###
# dev
###
# These are not part of the formal environment
PACKAGES_dev=(
  make
  podman
  codium
)

_install_k3s() {
  local download_path=$1
  local setup_script=${download_path}/setup.sh
  local install_script=${download_path}/install.sh
  local original_pwd=${PWD}
  cd ${download_path}
  __sudo ${setup_script}
  cd ${original_pwd}
  INSTALL_K3S_SKIP_DOWNLOAD="true" INSTALL_K3S_SKIP_SELINUX_RPM="true" bash ${install_script} --write-kubeconfig-mode 644
}

_install_dev()
{
  __copy_from_container_tar "${__INPUT_ARGS}/download-rocky.9.tar" "/download" "${__OUTPUT_ARGS}/download/rocky.9/"
  __install_from_local_dir "${__OUTPUT_ARGS}/download/rocky.9/download"
  __copy_from_container_tar "${__INPUT_ARGS}/download-web.tar" "/download" "${__OUTPUT_ARGS}/download/web/"
  _install_k3s "${__OUTPUT_ARGS}/download/web/download/k3s"
}

###
# FACTORY
###
_get_setup_functions()
{
  local match=(dev online offline)
  local suffix=${_SETUP_ENVIRONMENT_TYPE}
  if [[ ! " ${match[@]} " =~ " ${suffix} " ]]; then
    >&2 echo "Error: Invalid environment type: ${suffix}"
    exit 1
  fi
  local p_INSTALL_CMD="_install"
  local v_PACKAGES="PACKAGES_${suffix}"[@]
  f_INSTALL_CMD="${p_INSTALL_CMD}_${suffix}"
  a_PACKAGES=( "${!v_PACKAGES}" )
}

###############################################################################
# FUNCTION DEFINITIONS
###############################################################################
g_argparse()
{
  _ENV_FLAG=dev
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --env)
        _ENV_FLAG=$2
        shift;
        shift;
        ;;
      *) # positional arg
        g_POSITIONAL+=("$1") # save it in an array for later
        shift;
        ;;
    esac
  done
}
_setup() {
  local select_from=(podman docker buildah echo)
  __set_container_tool $(__select_command ${select_from[@]})
}

###############################################################################
# MAIN
###############################################################################
_main() {
  . ${__RUN_ARGPARSE}
  _SETUP_ENVIRONMENT_TYPE=${_ENV_FLAG}
  _get_setup_functions
  _setup
  ${f_INSTALL_CMD}
} # main ######################################################################
_main $@
