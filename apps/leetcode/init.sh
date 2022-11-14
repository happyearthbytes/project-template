#!/usr/bin/env bash
podman volume create leetcode_build_volume
podman build -f Containerfile --target tools_layer -t leetcode_base:latest
