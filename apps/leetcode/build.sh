#!/usr/bin/env bash
[ -z "$1" ] && exit 1
# cp CMakeLists.txt "$1"
# cp test_forever.sh "$1"
podman build -f Containerfile "$1" -t leetcode:latest
STATUS=$?
[ ${STATUS} == 0 ] && ./run.sh "$1"