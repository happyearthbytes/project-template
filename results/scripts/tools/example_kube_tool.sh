#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASE_PATH="$( cd -- "${SCRIPTPATH}/.." >/dev/null 2>&1 ; pwd -P )"

DEFAULT_ARGS=
RUNTIME_ARGS=(${@-${DEFAULT_ARGS}})

NAME="thing"
POD_NAME=${NAME}-`date +%s`
CONTAINER_NAME="${NAME}"
APPLY_FILE=${SCRIPTPATH}/${CONTAINER_NAME}.yml

function ctrl_c() {
        kubectl delete --ignore-not-found=true pod/${POD_NAME} -n overlord-test 1> /dev/null &
}
trap ctrl_c INT
trap ctrl_c SIGINT

if [[ $RUNTIME_ARGS ]]; then
    COMBINED=${RUNTIME_ARGS[@]}
    DELIMITED=\"${COMBINED// /\", \"}\"
    ACTUAL=$(kubectl apply -f ${APPLY_FILE} --dry-run=client -o json | \
      jq '.spec.containers[] |= ((select( .name | contains("'${CONTAINER_NAME}'")) | .args = ['"$DELIMITED"']) // .) | .metadata.name = "'"${POD_NAME}"'"')
    PARSED=$(echo ${ACTUAL} | \
      jq -c '.spec.containers[] | select( .name | contains("'${CONTAINER_NAME}'")) | .args')
    echo "Using args: ${PARSED}"
    echo ${ACTUAL} | kubectl apply -f - 1> /dev/null
else
    kubectl apply -f ${APPLY_FILE}  1> /dev/null
    POD_NAME="${NAME}"
fi

kubectl wait --for=condition=ready --timeout=5s -n overlord-test pod/${POD_NAME} 1> /dev/null
kubectl logs -f ${POD_NAME} -n overlord-test

ctrl_c
