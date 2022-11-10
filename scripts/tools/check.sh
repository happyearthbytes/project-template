
#!/usr/bin/env bash
# g_DEFAULT_ARGS=("a" "--verbose")
. "$(dirname "${BASH_SOURCE}")"/tool_common_include.sh
#==============================================================================

pushd "${__BASE_PATH}" || exit
# shellcheck disable=SC2046
./containers/cicd/bash/start.sh $(find . -name "*.sh")
popd || exit