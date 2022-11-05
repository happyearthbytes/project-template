#!/usr/bin/env bash

_set_encryption_key()
{
  local __ENCRYPTION_KEY=$1
  _create_temporary_encryption_dir
  echo "${TEMPORARY_ENCRYPTION_KEY}" > "${__TEMPORARY_ENCRYPTION_FILE}"
}
_set_encryption_file()
{
  local __ENCRYPTION_FILE=$1
  _create_temporary_encryption_dir
  cp "${TEMPORARY_ENCRYPTION_KEY}" > "${__TEMPORARY_ENCRYPTION_FILE}"
}

_create_temporary_encryption_dir()
{
  __TEMPORARY_ENCRYPTION_DIR=$(mktemp -d script-XXXXX)
  __TEMPORARY_ENCRYPTION_FILE=${__TEMPORARY_ENCRYPTION_DIR}/key.in
  chmod -R 700 "${__TEMPORARY_ENCRYPTION_DIR}"
}

_remove_temporary_encryption_dir()
{
  [ -d "${__TEMPORARY_ENCRYPTION_DIR}" ] && rm -rf "${__TEMPORARY_ENCRYPTION_DIR}"
}

_compress_dir()
{
  local INPUT_DIR=$1
  local OUTPUT_FILE=$2
  tar -cf "${OUTPUT_FILE}" --exclude-vcs  -I "gzip --best" -C "${INPUT_DIR}" .
}
_decompress_dir()
{
  local INPUT_FILE=$1
  local OUTPUT_DIR=$2
  if [ ! -d "${OUTPUT_DIR}" ]; then
    mkdir -p "${OUTPUT_DIR}"
  fi
  tar -xf "${INPUT_FILE}" -C "${OUTPUT_DIR}"
}

_encrypt_file()
{
  local INPUT_FILE=$1
  local OUTPUT_FILE=$2
  local ENCRYPTION=$3
  if [ -f "${ENCRYPTION}" ]; then
    _set_encryption_file "${ENCRYPTION}"
  else
    _set_encryption_key "${ENCRYPTION}"
  fi
  openssl enc -aes-256-cbc -pbkdf2 -iter 10000 -salt -in "${INPUT_FILE}" -out "${OUTPUT_FILE}" -pass file:"${__TEMPORARY_ENCRYPTION_FILE}"
  _remove_temporary_encryption_dir
}

_decrypt_file()
{
  local INPUT_FILE=$1
  local OUTPUT_FILE=$2
  local ENCRYPTION=$3
  if [ -f "${ENCRYPTION}" ]; then
    _set_encryption_file "${ENCRYPTION}"
  else
    _set_encryption_key "${ENCRYPTION}"
  fi
  openssl aes-256-cbc -d -pbkdf2 -in "${INPUT_FILE}" -out "${OUTPUT_FILE}" -pass file:"${__TEMPORARY_ENCRYPTION_FILE}"
  _remove_temporary_encryption_dir
}

_xxd_encode()
{
  __debug "_xxd_encode ${@}"
  local INPUT_FILE=$1
  local OUTPUT_FILE=$2
  xxd -ps -g1 -c40 "${INPUT_FILE}" > "${OUTPUT_FILE}"
}

_xxd_decode()
{
  local INPUT_FILE=$1
  local OUTPUT_FILE=$2
  xxd -ps -g1 -c40 -r "${INPUT_FILE}" > "${OUTPUT_FILE}"
}

_compress_encrypt()
{
  local INPUT_DIR=$1
  local OUTPUT_FILE=$2
  local ENCRYPTION=$3
  local INTERMEDIATE_FILE=compress.in.tar.gz
  local INTERMEDIATE_FILE_2=enc.in.tar.gz

  __debug "${@}"
  if [ -f "${INPUT_DIR}" ];
  then
    INPUT_FILE="${INPUT_DIR}"
    INPUT_DIR="tmp/"
    cp "${INPUT_FILE}" "${INPUT_DIR}"
  fi

  find "${INPUT_DIR}" -type f | sort | head -1 | while read file; do _file_cksum_check "$file"; done
  _compress_dir "${INPUT_DIR}" ${INTERMEDIATE_FILE}
  _file_cksum_check ${INTERMEDIATE_FILE}
  _encrypt_file ${INTERMEDIATE_FILE} ${INTERMEDIATE_FILE_2} "${ENCRYPTION}"
  _file_cksum_check ${INTERMEDIATE_FILE_2}
  rm ${INTERMEDIATE_FILE}
  _xxd_encode ${INTERMEDIATE_FILE_2} "${OUTPUT_FILE}"
  rm ${INTERMEDIATE_FILE_2}
  _file_cksum_check "${OUTPUT_FILE}"
}
_decompress_decrypt()
{
  local INPUT_FILE=$1
  local OUTPUT_DIR=$2
  local ENCRYPTION=$3
  local INTERMEDIATE_FILE=enc.out.tar.gz
  local INTERMEDIATE_FILE_2=compress.out.tar.gz
  _file_cksum_check "${INPUT_FILE}"
  _xxd_decode "${INPUT_FILE}" ${INTERMEDIATE_FILE}
  _file_cksum_check ${INTERMEDIATE_FILE}
  _decrypt_file ${INTERMEDIATE_FILE} ${INTERMEDIATE_FILE_2} "${ENCRYPTION}"
  rm ${INTERMEDIATE_FILE}
  _file_cksum_check ${INTERMEDIATE_FILE_2}
  _decompress_dir ${INTERMEDIATE_FILE_2} "${OUTPUT_DIR}"
  find "${OUTPUT_DIR}" -type f | sort | head -1 | while read file; do _file_cksum_check "$file"; done
  rm ${INTERMEDIATE_FILE_2}
}

_file_cksum_check()
{
  local INPUT_FILE=$1
  local file_contents=$(echo $(head -c 4 "${INPUT_FILE}" | od -An -tc | xargs | sed 's/[0-9]\{3\}/-/g' | sed 's/ //g')---- | head -c 4)
  echo -n "> ${file_contents} <   "
  cksum "${INPUT_FILE}"
}

_test()
{
  local INPUT_FILE=$1
  if [ -e "${INPUT_FILE}" ];
  then
    cp -r "${INPUT_FILE}" _test_dir/
  else
    echo "test_contents" > _test_dir/test.txt
  fi
  local INPUT_DIR=_test_dir
  local OUTPUT_FILE=out.txt
  local OUTPUT_DIR=decrypted
  local ENCRYPTION=notarealpassword
  _compress_encrypt ${INPUT_DIR} ${OUTPUT_FILE} ${ENCRYPTION}
  rm -rf _test_dir
  _decompress_decrypt ${OUTPUT_FILE} ${OUTPUT_DIR} ${ENCRYPTION}
  rm ${OUTPUT_FILE}
  rm -rf ${OUTPUT_DIR}
}

_main()
{
  if [ "$1" == "-e" ]; then
    shift
    _compress_encrypt $@
  elif [ "$1" == "-d" ]; then
    shift
    _decompress_decrypt $@
  else
    _test $@
  fi
}
