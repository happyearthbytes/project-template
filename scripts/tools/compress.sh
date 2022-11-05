
#!/usr/bin/env bash
# g_DEFAULT_ARGS=("a" "--verbose")
. "$(dirname "${BASH_SOURCE}")"/tool_common_include.sh
#==============================================================================
g_DEFAULT_ARGS=("--input" "." "--output" "~/tmp/out")

# Includes
. "${__LIBS}"/lib_compress.sh

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
      --compress)
        _COMPRESS_FLAG=true
        shift;
        ;;
      --extract)
        _EXTRACT_FLAG=true
        shift;
        ;;
      --key)
        _KEY=$2
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

# MAIN FUNCTIONS
#==============================================================================
_apply() {

  if [ -z "${_KEY}" ]; then
    __log "no key"
    _KEY="thereisnokey"
  fi
  if [ -z "${__INPUT_ARGS[@]}" ]; then
    __log "no input"
    __INPUT_ARGS=~/tmp/in
  fi
  if [ -z "${__OUTPUT_ARGS[@]}" ]; then
    __log "no output"
    __OUTPUT_ARGS=~/tmp/out
  fi

  if [ ! -z "${_COMPRESS_FLAG}" ]; then
    _compress_encrypt "${__INPUT_ARGS[@]}" "${__OUTPUT_ARGS[@]}" "${_KEY}"
  elif [ ! -z "${_EXTRACT_FLAG}" ]; then
    _decompress_decrypt "${__INPUT_ARGS[@]}" "${__OUTPUT_ARGS[@]}" "${_KEY}"
  else
    __log "You did nothing"
  fi
}

###############################################################################
# MAIN
###############################################################################
_main() {
  . "${__RUN_ARGPARSE}"
  _apply
} # main ######################################################################

_main "${@}"