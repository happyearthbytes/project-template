#!/usr/bin/env bash
__log() {
  if [ "${__QUIET_FLAG}" != true ];
  then
    echo "$@"
  fi
}
__debug() {
  if [ "${__VERBOSE_FLAG}" == true ];
  then
    echo "DEBUG: $*"
  fi
}

###############################################################################
# LIB
###############################################################################
T_bold="\033[1m"
T_ital="\033[3m"
T_under="\033[4m"
T_good="\033[0;32m"
T_bad="\033[0;31m"
T_item="\033[0;34m"
T_special="\033[0;33m"
T_contrast="\033[0;7m"
T_warn="\033[45;1m"
T_err="\033[41;1m"
T_info="\033[44;1m"
T_reset="\033[0m"
p_item() {
  printf "${T_item}${1}${T_reset}\n"
}
p_error() {
  printf "${T_bad}${1}${T_reset}\n"
}
p_ital() {
  printf "${T_ital}${1}${T_reset}\n"
}
p_normal() {
  printf "${T_reset}${1}\n"
}
p_() {
  printf "${1}"
}
p_format_args() {
  printf "$1\n" | sed 's|-.*  |\x1b[3m\x1b[1m\x1b[34m&\x1b[0m|'
}
