#!/usr/bin/env bash

podman machine list
echo podman machine stop podman-machine-default
echo podman machine rm podman-machine-default
podman machine init --rootful k3s-machine # not recommended if you don't need
podman machine start k3s-machine
podman machine inspect k3s-machine
podman machine list
