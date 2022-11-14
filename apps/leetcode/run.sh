#!/usr/bin/env bash
SRC_DIR=$1
podman run -it --rm -v "${PWD}":/pwd -v "${SRC_DIR}":/src -v leetcode_build_volume:/build -w /pwd leetcode:latest
