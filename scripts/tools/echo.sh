#!/usr/bin/env bash
# g_DEFAULT_ARGS=("a" "--verbose")
. "$(dirname "${BASH_SOURCE}")"/tool_common_include.sh
#==============================================================================

# DOCUMENTATION
#==============================================================================

###############################################################################
# FUNCTION DEFINITIONS
###############################################################################
g_argparse()
{
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --unused)
        _UNUSED_FLAG=true
        shift;
        ;;
      *) # positional arg
        g_POSITIONAL+=("$1") # save it in an array for later
        shift;
        ;;
    esac
  done
}

# MAIN FUNCTIONS
#==============================================================================
_apply() {
  __log "hello."
  __log "${@}"
  __debug " --- ${*}"
}

###############################################################################
# MAIN
###############################################################################
_main() {
  . "${__RUN_ARGPARSE}"
  _apply "${__INPUT_ARGS[@]}" "${__OUTPUT_ARGS[@]}"
} # main ######################################################################

_main "${@}"