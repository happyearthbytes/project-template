PY_APP="app"
PYTHON3="python3"
SETUP_PY="setup.py"
PYLINT="pylint"

${PYTHON3} ${SETUP_PY} sdist
${PYTHON3} -m package -x
${PYTHON3} -m coverage run -m pytest . --junitxml=junit.xml
${PYTHON3} -m coverage xml
${PYLINT} --rcfile=pylintrc --exit-zero ${PY_APP} > pylint.txt

SPHINX_API="sphinx"
DOC_DIR="document"
PROJ_NAME="Project Name"
CREATOR="Me"
DOC_VER="0.0"
DOC_REV="0.0.x"
SPHINX_MODULE_PATH="."

${SPHINX_API} -F -f -a -o ${DOC_DIR} ${SPHINX_MODULE_PATH}
        -H ${PROJ_NAME} -A ${CREATOR}
        -V ${DOC_VER} -R ${DOC_REV}


make -C ${DOC_DIR} PATH="${SPHINX_PATH}"':${PATH}' html
