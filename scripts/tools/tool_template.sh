#!/usr/bin/env bash
# g_DEFAULT_ARGS=("a" "--verbose")
. $(dirname "${BASH_SOURCE}")/tool_common_include.sh
#==============================================================================

# Includes
. ${__LIBS}/lib_compress.sh

# DOCUMENTATION
#==============================================================================
g_VERSION=0.1.0
g_SCRIPT_DESCRIPTION=$(cat <<-EOF
  my desc
EOF
)
g_SCRIPT_DETAILS=$(cat <<-EOF
  my script
  details
EOF
)
g_SCRIPT_OPTIONS=$(cat <<-EOF
[ -h | -a ]
EOF
)
g_SCRIPT_ARGS=$(cat <<-EOF
Options:
  -h, --help             print help message
  -a, --apply            thing
EOF
)

###############################################################################
# FUNCTION DEFINITIONS
###############################################################################
g_argparse()
{
  _APPLY_FLAG=false
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      -a|--apply)
        _APPLY_FLAG=true
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
  __log "This is the Apply Function"
  __debug "Apply Function debug"
}

###############################################################################
# MAIN
###############################################################################
_SOME_VAR=invalid


_main() {
. ${__RUN_ARGPARSE}

if [ ${_APPLY_FLAG} == true ]; then
  _apply
fi

} # main ######################################################################

_main $@