#!/usr/bin/env bash
podman build --layers --target server --jobs 2 --tag k3s:server .
podman build --layers --target worker --jobs 2 --tag k3s:worker .
podman build --layers --target node   --jobs 2 --tag k3s:node   .