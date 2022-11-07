#!/usr/bin/env bash
# shellcheck disable=SC2034
g_DEFAULT_ARGS=
source "$(dirname "${BASH_SOURCE}")"/tool_common_include.sh
#==============================================================================

# Includes
. "${__LIBS}"/lib_network.sh
. "${__LIBS}"/lib_package_management.sh


###
# Utilities
###
_online_install_vscode()
{
  if [ -z "${INSTALL_CODIUM}" ]; then
    # vscode
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  else
    # codium
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo > /dev/null
  fi
}
_clean_install_vscode()
{
  if [ -z "${INSTALL_CODIUM}" ]; then
    # vscode
    __remove_repos /etc/yum.repos.d/vscode.repo
  else
    # codium
    __remove_repos /etc/yum.repos.d/vscodium.repo
  fi
}

###
# online
###
_setup_online_t()
{
  echo "Not implemented"
}
l_decorate d_debug _setup_online_t _setup_online

###
# dev
###
# These are not part of the formal environment
# shellcheck disable=SC2034
PACKAGES_dev=(
  make
  podman
  # codium
  code
)
_setup_dev_t()
{
  _online_install_vscode
  __update_repos "${a_REPOS[@]}"
  __install_from_web "${a_PACKAGES[@]}"
  _clean_install_vscode
}
l_decorate d_debug _setup_dev_t _setup_dev

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
  local p_SETUP_CMD="_setup"
  local v_REPOS="REPOS_${suffix}"[@]
  local v_PACKAGES="PACKAGES_${suffix}"[@]
  f_SETUP_CMD="${p_SETUP_CMD}_${suffix}"
  a_REPOS=( "${!v_REPOS}" )
  a_PACKAGES=( "${!v_PACKAGES}" )
}

###############################################################################
# FUNCTION DEFINITIONS
###############################################################################
g_argparse()
{
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




###############################################################################
# MAIN
###############################################################################
_main() {
  . "${__RUN_ARGPARSE}"

  if [ -z "${_ENV_FLAG}" ]; then
    local select_from=("bootstrap" "online-cicd")
    local -r selection=$(__user_select "${select_from[@]}" "Select your environment:")
  fi
  _ENV_FLAG=${selection}
  echo "$_ENV_FLAG"
  exit
  _SETUP_ENVIRONMENT_TYPE=${_ENV_FLAG}
  _get_setup_functions
  ${f_SETUP_CMD}
} # main ######################################################################
_main "${@}"
