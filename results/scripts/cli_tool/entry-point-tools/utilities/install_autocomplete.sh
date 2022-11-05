#!/usr/bin/env bash
BASHRC=~/.bashrc
INSTALL_TO_PATH=/usr/local/bin
UTILITY_DIR="$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )"
COMMAND_NAME=`${UTILITY_DIR}/get_config_val.sh project_name`
INSTALL_COMMAND="${INSTALL_TO_PATH}/${COMMAND_NAME}-tools/utilities/autocomplete.sh"

# Make sure .bashrc exists
if ! [ -e "${BASHRC}" ]; then
  echo "${BASHRC} not found. creating it."
  echo " " > ${BASHRC}
fi

# first check to see if ~/.bashrc already calls setup_bashrc.sh
grep -q "^. ${INSTALL_COMMAND}$" ${BASHRC}
if ! [ $? -eq 0 ]
then
  # update your bashrc to source the setup script
  echo "updating ${BASHRC} to invoke ${INSTALL_COMMAND}"
  sed -i "1i. ${INSTALL_COMMAND}" ${BASHRC}
fi