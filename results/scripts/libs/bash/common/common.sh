###############################################################################
# VARIABLE DEFINITIONS
###############################################################################

if [ ! -z $__COMMON_INSTALLED ]; then
  return
fi
__COMMON_INSTALLED=true

. $(dirname "${BASH_SOURCE}")/common_vars.sh
. $(dirname "${BASH_SOURCE}")/common_logging.sh
. $(dirname "${BASH_SOURCE}")/common_decorators.sh
. $(dirname "${BASH_SOURCE}")/common_paths.sh
. $(dirname "${BASH_SOURCE}")/common_argparse.sh
. $(dirname "${BASH_SOURCE}")/common_utilities.sh
#==============================================================================

###############################################################################
# MAIN
###############################################################################

main()
{
  __print_header
}
main
