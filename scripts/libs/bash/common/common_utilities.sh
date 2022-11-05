__sudo(){
  SUDO_ARGS=$@
  # if sudo doesn't exist, just run the regular command
  SUDO_CMD=$(command -v sudo)

  if [ -z ${LOCAL_PASSWORD} ];
  then
    set -o xtrace
    ${SUDO_CMD} ${SUDO_ARGS[@]}
    set +o xtrace
  else
    set -o xtrace
    echo ${LOCAL_PASSWORD} | ${SUDO_CMD} -S ${SUDO_ARGS[@]}
    set +o xtrace
  fi
}
__local_password() {
  read -s -p "Local Password (${LOCAL_USER}):" LOCAL_PASSWORD < /dev/tty
  echo
}
__print_header() {
  __debug "--------------------------------"
  __debug "- $0"
  __debug "--------------------------------"
}

# Example:
# local select_from=(select_1 select_2 echo)
# $(__select_command ${select_from[@]})
__select_command() {
  local command_list=$@
  local selected_command=
  for this_command in ${command_list[@]}; do
      selected_command=$(command -v ${this_command})
      [ ! -z "${selected_command}" ] && break
  done
  echo "${selected_command}"
}

