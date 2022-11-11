#!/usr/bin/env bash
SPHINX_API=sphinx
DOC_DIR="document"
PROJ_NAME="Project Name"
CREATOR="Me"
DOC_VER="0.0"
DOC_REV="0.0.x"
SPHINX_MODULE_PATH="."

${SPHINX_API} -F -f -o ${DOC_DIR} ${SPHINX_MODULE_PATH}\
        -H "${PROJ_NAME}" -A ${CREATOR}\
        -V ${DOC_VER} -R ${DOC_REV}

make -C ${DOC_DIR} PATH="${SPHINX_PATH}"':${PATH}' singlehtml