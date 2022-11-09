#!/usr/bin/env bash

podman machine list
echo podman machine stop k3s-machine
echo podman machine rm k3s-machine
podman machine init --rootful k3s-machine # not recommended if you don't need
podman machine start k3s-machine
podman machine inspect k3s-machine
podman machine list
