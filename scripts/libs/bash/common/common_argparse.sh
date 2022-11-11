#!/usr/bin/env bash
# COMMON
#==============================================================================
__VERBOSE_FLAG=false
__QUIET_FLAG=false
__INPUT_ARGS=()
__OUTPUT_ARGS=()
__common_args() {
  # Initialize common
  g_POSITIONAL=()
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      -h|--help)
        __help
        exit 0
        ;;
      --version)
        echo "${g_VERSION}"
        exit 0
        ;;
      --verbose)
        __VERBOSE_FLAG=true
        shift;
        ;;
      --quiet)
        __QUIET_FLAG=true
        shift;
        ;;
      --dry-run)
        __DRYRUN_FLAG=true
        shift;
        ;;
      -i|--input)
        [ -z "$2" ] && __help
        __INPUT_ARGS+=("$2")
        shift;
        shift;
        ;;
      -o|--output)
        [ -z "$2" ] && __help
        __OUTPUT_ARGS+=("$2")
        shift;
        shift;
        ;;
      *) # positional arg
        g_POSITIONAL+=("$1") # save it in an array for later
        shift
        ;;
    esac
  done
}
__extra_args() {
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --*|-*) # unknown option
        __help
        shift
        ;;
      *) # positional arg
        shift
        ;;
    esac
  done
  set -- "${g_POSITIONAL[@]}" # restore positional parameters
  __debug "Positional args: ($@)"
}
# HELP
#==============================================================================
__help() {
  p_normal "${T_bold}Usage: ${SCRIPT_NAME} ${g_SCRIPT_OPTIONS}${T_reset}"
  p_ "  ${T_special}${SCRIPT_NAME} ${g_VERSION}${T_reset}\n"
  p_ital "${g_SCRIPT_DESCRIPTION}\n"
  p_normal "${g_SCRIPT_DETAILS}\n"
  p_format_args "${g_SCRIPT_ARGS}"
  p_error "\nUsing Args: ${__USED_ARGS}"

  exit 1
}

###############################################################################
# MAIN
###############################################################################

# Initilize globals
g_VERSION=0.0.0
g_SCRIPT_DESCRIPTION=$(cat <<-EOF
  default description
EOF
)
g_SCRIPT_DETAILS=$(cat <<-EOF
    default script details
    ......................
EOF
)
g_SCRIPT_OPTIONS=$(cat <<-EOF
[ -h | --version | --verbose | --quiet ]
EOF
)
g_SCRIPT_ARGS=$(cat <<-EOF
Options:
  -h, --help             print help message
  --version              version
  --verbose              verbose
  --quiet                quiet
  --input IN             input
  --output OUT           output
  --dry-run              dry-run
EOF
)
g_POSITIONAL=()
g_argparse()
{
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      *) # positional arg
        g_POSITIONAL+=("$1") # save it in an array for later
        shift;
        ;;
    esac
  done
}
# Save input to script
__INITIAL_ARGS=$@
# Set a default arg if not defined
set -- "${@-${g_DEFAULT_ARGS[@]}}"
# Parse the common args
__common_args $@
__debug "Input Args: ${__INITIAL_ARGS}"
# Define the command to run in the script
# . ${__RUN_ARGPARSE}
__RUN_ARGPARSE=${__COMMON}/run_argparse.sh
set -- "${g_POSITIONAL[@]}" # restore positional parameters
