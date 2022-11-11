#!/usr/bin/env bash

#TODO utilize docker for this type of thing.

echo "========================================================================="
echo "$0"
echo "========================================================================="
ROOT_DIR="$(realpath $( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )/..)"
# This requires that the download was already performed
PKG_DIR=${ROOT_DIR}/download/general_tools
ORIG_PACKAGES=${PKG_DIR}/orig-packages/
CACHE_DIR=/var/cache/apt/archives

mkdir -p "${PKG_DIR}"
cd ${PKG_DIR} || exit

sudo apt-get update

# Backup original cache
mkdir -p "${ORIG_PACKAGES}"
# NOTE THAT THIS ASSUMES THAT THE ORIGINAL CACHE REPRESENTS A CLEAN STATE
sudo cp -r ${CACHE_DIR}/* "${ORIG_PACKAGES}"

PACKAGES="git make build-essential cmake openssh-server python-dev"
for package in $PACKAGES
do
    echo "----------------"
    echo "${package}"
    echo "----------------"
    echo "do a download only - to cache"
    sudo apt install -y "${package}" -d
    echo "Copy all cached debs"
    THIS_PACKAGE_DIR=${PKG_DIR}/${package}
    mkdir -p "${THIS_PACKAGE_DIR}"
    sudo cp ${CACHE_DIR}/*.deb "${THIS_PACKAGE_DIR}"/
    echo "Remove copies from original cache"
    cd ${ORIG_PACKAGES} || exit
    sudo find . -name "*.deb" -exec rm "${THIS_PACKAGE_DIR}"/{} \;
    echo "Remove new cached deb files"
    cd ${THIS_PACKAGE_DIR} || exit
    sudo find . -name "*.deb" -exec rm ${CACHE_DIR}/{} \;
done