#!/usr/bin/env bash
###
# common
# Usage: l-decorate d-debug _setup_cmd _setup_cmd-d
#
# This will produce a new function: _setup_cmd-d
# From existing function: _setup_cmd
# By decorating it with the existing decorator: d-debug
# Where the decorator can run the original function by calling: $@
#
# Add multiple layers of decoration like this:
# l-decorate d-debug _setup_cmd _setup_cmd-d
# l-decorate d-debug _setup_cmd-d _setup_cmd-x
###
l_decorate()
{
  local DECORATOR_NAME=$1
  local FUNCTION_NAME=$2
  local NEW_FUNCTION_NAME=$3
  eval "${NEW_FUNCTION_NAME}() { ${DECORATOR_NAME} ${FUNCTION_NAME} \$@; }"
}

###
# Decorators
###
LEVEL="-"
d_debug()
{
  >&2 echo ${LEVEL}"\\"
  LEVEL="${LEVEL}-"
  >&2 echo "(debug) ${*}"
  $@
  LEVEL="${LEVEL:1:${#LEVEL}}"
  >&2 echo ${LEVEL}"/"
}
