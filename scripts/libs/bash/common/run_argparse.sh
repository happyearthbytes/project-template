#!/usr/bin/env bash
# Set a default arg if not defined
set -- "${g_POSITIONAL[@]}" # restore positional parameters
if [ -z ${g_DEFAULT_ARGS+x} ];
then
  g_DEFAULT_ARGS="--help"
fi
set -- "${@-${g_DEFAULT_ARGS[@]}}"
# Save the args that are being used. apply defaults if none defined
__USED_ARGS=$@
# Parse the common args
__common_args $@
set -- "${g_POSITIONAL[@]}" # restore positional parameters
__debug "Using Args: ${__USED_ARGS[@]}"
g_POSITIONAL=() # set extra positional args in g_argparse
g_argparse $@ # Run the script defined function
__extra_args ${g_POSITIONAL[@]} # Reject undefined flags
set -- "${g_POSITIONAL[@]}" # restore positional parameters