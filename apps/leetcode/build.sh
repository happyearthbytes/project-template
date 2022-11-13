#!/usr/bin/env bash
cp CMakeLists.txt "$1"
podman build -f Containerfile "$1" -t leetcode:latest