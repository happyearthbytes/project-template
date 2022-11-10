#!/usr/bin/env bash
# podman run -it --rm -v shellcheck-vol:/stuff rockylinux:9
podman run -it --rm -v "${PWD}":/pwd -w /pwd --mount type=image,source=cicd:shellcheck,destination=/opt rockylinux:9 /opt/shellcheck "${@}"
