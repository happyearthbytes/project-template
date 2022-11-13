#!/usr/bin/env bash
podman build -f Containerfile --target tools_layer -t leetcode_base:latest
