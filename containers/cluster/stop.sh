#!/usr/bin/env bash

podman pod stop k3s-pod
# podman pod stop k3sn
podman pod rm k3s-pod --force
# podman pod rm k3sn --force
podman pod prune --force
podman container prune --force