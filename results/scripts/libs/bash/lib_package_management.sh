#!/usr/bin/env bash

###############################################################################
# VARS
###############################################################################
PACKAGE_DOWNLOAD_DIR="."

###############################################################################
# Package utils
###############################################################################
__set_package_download_dir()
{
  PACKAGE_DOWNLOAD_DIR=$1
}
__clean_downloads()
{
  rm ${PACKAGE_DOWNLOAD_DIR}/*
}

###############################################################################
# Package Tool info
###############################################################################
__pkg_tool()
{
  # Return if already defined
  if [ ! -z "${DOWNLOAD_TOOL}" ]; then
    echo ${DOWNLOAD_TOOL}; return
  fi
  DOWNLOAD_TOOLS=(
    dnf
    yum
    apt
    apk
    wget
    ""
  )
  for this_download_tool in "${DOWNLOAD_TOOLS[@]}"; do
    DOWNLOAD_TOOL=$(command -v ${this_download_tool})
    if [ ! -z "${DOWNLOAD_TOOL}" ]; then
      echo ${DOWNLOAD_TOOL}; return
    fi
  done
}

__pkg_tool_ver()
{
  # Return if there is no command
  if [ -z "${DOWNLOAD_TOOL}" ] || [ ! -z "${DOWNLOAD_TOOL_VERSION}" ]; then
    echo ${DOWNLOAD_TOOL_VERSION}; return
  fi
  case ${DOWNLOAD_TOOL} in
    *dnf | *yum)
      DOWNLOAD_TOOL_VERSION=$(${DOWNLOAD_TOOL} --version | head -1)
      ;;
    *apt)
      DOWNLOAD_TOOL_VERSION=$(${DOWNLOAD_TOOL} --version | cut -f2 -d" ")
      ;;
    *apk)
      DOWNLOAD_TOOL_VERSION=$(${DOWNLOAD_TOOL} cut -f2 -d" " | head -c -2)
      ;;
    *wget)
      DOWNLOAD_TOOL_VERSION=$(${DOWNLOAD_TOOL} --version | head -1 | cut -f3 -d" ")
      ;;
    *)
      ;;
  esac
  echo ${DOWNLOAD_TOOL_VERSION}; return
}

#######################################
# DNF
#######################################
__pkg_get_all_deps_dnf()
{
  PACKAGES=$@
  # PACKAGE_NAMES=$(_sudo ${DOWNLOAD_TOOL} list --available ${PACKAGES[@]} | tail -n +3 | awk '{print $1}')
  PACKAGE_NAMES=$(_sudo ${DOWNLOAD_TOOL} repoquery --available --quiet ${PACKAGES[@]})
  # Reqursively list all dependencies
  DEPENDENCIES=$(_sudo ${DOWNLOAD_TOOL} repoquery --arch x86_64 --arch noarch --quiet --requires --recursive --resolve ${PACKAGES[@]} | sed -e '/langpack-en/ s/.*/%&/' -e '/^[^%].*langpack-[a-z]/ d' -e '/^%/ s/^%//')
  RVAL=(
  ${PACKAGE_NAMES}
  ${DEPENDENCIES}
  )
  echo ${RVAL[@]}
}
__pkg_get_new_deps_dnf()
{
  PACKAGES=$@
  RVAL=$(_sudo ${DOWNLOAD_TOOL} list --available ${PACKAGES[@]} | tail -n +3 | awk '{print $1}')
  echo ${RVAL}
}
__pkg_download_dnf()
{
  PACKAGES=$@
  RVAL="_sudo ${DOWNLOAD_TOOL} -y --allowerasing --downloadonly\
    --destdir ${PACKAGE_DOWNLOAD_DIR}\
    install ${PACKAGES[@]}"
  echo ${RVAL}
}
__pkg_get_url_dnf()
{
  PACKAGES=$@
  # list download url
  RVAL=$(dnf download --url ${PACKAGES[@]})
  echo ${RVAL}
}

#######################################
# Defaults
#######################################
__pkg_get_all_deps_none()
{
  RVAL=echo
  echo ${RVAL}
}
__pkg_get_new_deps_none()
{
  RVAL=echo
  echo ${RVAL}
}
__pkg_download_none()
{
  RVAL=echo
  echo ${RVAL}
}
__pkg_get_url_none()
{
  RVAL=echo
  echo ${RVAL}
}

#######################################
# FACTORY
#######################################
__get_pkg_functions()
{
  __pkg_tool > /dev/null
  __pkg_tool_ver > /dev/null
  case "${DOWNLOAD_TOOL}-${DOWNLOAD_TOOL_VERSION}" in
    *dnf-*)
      FUNCTION_SUFFIX="dnf"
      ;;
    *apt-*)
      FUNCTION_SUFFIX="none"
      ;;
    *apk-*)
      FUNCTION_SUFFIX="none"
      ;;
    *wget-*)
      FUNCTION_SUFFIX="none"
      ;;
    *)
      FUNCTION_SUFFIX="none"
      ;;
  esac
  PKG_DOWNLOAD_CMD_PRE="_pkg_download"
  GET_ALL_DEPS_CMD_PRE="_pkg_get_all_deps"
  GET_NEW_DEPS_CMD_PRE="_pkg_get_new_deps"
  GET_PKG_URL_CMD_PRE="_pkg_get_url"
  PKG_DOWNLOAD_CMD="${PKG_DOWNLOAD_CMD_PRE}_${FUNCTION_SUFFIX}"
  GET_ALL_DEPS_CMD="${GET_ALL_DEPS_CMD_PRE}_${FUNCTION_SUFFIX}"
  GET_NEW_DEPS_CMD="${GET_NEW_DEPS_CMD_PRE}_${FUNCTION_SUFFIX}"
  GET_PKG_URL_CMD="${GET_PKG_URL_CMD_PRE}_${FUNCTION_SUFFIX}"
}
__pkg_download_cmd()
{
  # Return if there is no command
  if [ ! -z "${PKG_DOWNLOAD_CMD}" ]; then
    echo ${PKG_DOWNLOAD_CMD}; return
  fi
  __get_pkg_functions
  RVAL=${PKG_DOWNLOAD_CMD}
  echo ${RVAL}
}
__pkg_get_all_deps_cmd()
{
  # Return if there is no command
  if [ ! -z "${GET_ALL_DEPS_CMD}" ]; then
    echo ${GET_ALL_DEPS_CMD}; return
  fi
  __get_pkg_functions
  RVAL=${GET_ALL_DEPS_CMD}
  echo ${RVAL}
}
__pkg_get_new_deps_cmd()
{
  # Return if there is no command
  if [ ! -z "${GET_NEW_DEPS_CMD}" ]; then
    echo ${GET_NEW_DEPS_CMD}; return
  fi
  __get_pkg_functions
  RVAL=${GET_NEW_DEPS_CMD}
  echo $RVAL
}
__pkg_get_url_cmd()
{
  # Return if there is no command
  if [ ! -z "${GET_PKG_URL_CMD}" ]; then
    echo ${GET_PKG_URL_CMD}; return
  fi
  __get_pkg_functions
  RVAL=${GET_PKG_URL_CMD}
  echo $RVAL
}

###############################################################################
# Package commands
###############################################################################


###############################################################################
# Download
###############################################################################
__download_packages()
{
  PACKAGES=$@
  echo "===================="
  echo "Downloading: ${PACKAGES[@]}"
  $($(_pkg_download_cmd) ${PACKAGES[@]})
  # ADDLINE="max_parallel_downloads=10"
  # _sudo sed -i -e '$a '$ADDLINE -e '/^'$ADDLINE'$/ d' /etc/dnf/dnf.conf
  # dnf download --destdir ${PACKAGE_DOWNLOAD_DIR} ${PACKAGES}
}
__download()
{
  PACKAGES=$@
  echo "Downloading Packages: ${PACKAGES[@]}"
  __get_pkg_functions
  DEPS=$($(_pkg_get_all_deps_cmd) ${PACKAGES[@]})
  NEW_DEPS=$($(_pkg_get_new_deps_cmd) ${DEPS[@]})
  __download_packages ${NEW_DEPS[@]}
}
__download_dependencies()
{
  PACKAGES=$@
  echo "Downloading Packages and Dependencies: ${PACKAGES[@]}"
  __get_pkg_functions
  DEPS=$($(_pkg_get_all_deps_cmd) ${PACKAGES[@]})
  __download_packages ${DEPS[@]}
}

###############################################################################
# Install
###############################################################################
__install_from_web ()
{
  PACKAGES=$@
  echo "Installing: ${PACKAGES[@]}"
  __sudo dnf install -y ${PACKAGES[@]}
}
__install_from_rpm()
{
  PACKAGES=$@
  echo "Installing: ${PACKAGES[@]}"
  __sudo dnf install -y --skip-broken --allowerasing --cacheonly --disablerepo=* ${PACKAGES[@]}
}
__install_from_local_dir()
{
  local rpm_dir=$@
  echo "Installing: ${rpm_dir[@]}"
  __sudo dnf localinstall -y --skip-broken --cacheonly --disablerepo=* ${rpm_dir[@]}/*.rpm
}
__install_from_local_repo()
{
  PACKAGES=$@
  echo "Installing: ${PACKAGES[@]}"
  __sudo dnf install -y --disablerepo=* --enablerepo=local_setup ${PACKAGES[@]}
}

###############################################################################
# Repo Management
###############################################################################
__update_repos ()
{
  REPOS=$@
  if [ ${#REPOS} == 0 ]; then return; fi
  sudo dnf config-manager `echo "${REPOS[@]}" | sed -e 's/ / --add-repo /g' -e 's/^/--add-repo /'`
  dnf makecache
}
__remove_repos ()
{
  REPOS=$@
  __sudo rm `echo " ${REPOS[@]}" | sed -e 's| *[^ ]*/| /etc/yum.repos.d/|g'` || true
}
__make_local_repo()
{
  REPO_NAME=$1
  REPO_FILE="/etc/yum.repos.d/${REPO_NAME}.repo"
  createrepo_c ${PACKAGE_DOWNLOAD_DIR}
  repo2module ${PACKAGE_DOWNLOAD_DIR} ${PACKAGE_DOWNLOAD_DIR}/modules.yaml
  cat << EOF  | sudo tee ${REPO_FILE} > /dev/null
[${REPO_NAME}]
name=${REPO_NAME}
baseurl=file:///${PACKAGE_DOWNLOAD_DIR}
enabled=1
gpgcheck=0
protect=1
EOF
  __update_repos ${REPO_FILE}
}
#=================
_add_stream_repo()
{
  __sudo sed -s -i '\|http://artifactory.devlnk.net/artifactory/centos-remote| s|\($releasever\)/|\1-stream/|' /etc/yum.repos.d/*
  __update_repos `grep -lr "artifactory.devlnk.net" /etc/yum.repos.d/`
}