#!/usr/bin/env bash
COMMON_ARGS=(
  "--env-file" ".env"
  "--replace"
  "--rm"
  "--stop-timeout" "3"
  "--timeout" "1000"
  "--network" "k3s-network"
)
SERVER_ARGS=(
  "${COMMON_ARGS[@]}"
  "--volumes" "k3s-server-volume:/var/lib/rancher/k3s"
  "--volumes" ".:/output"
  "--publish" "6443:6443"
  "--name" "k3s-server"
)
WORKER_ARGS=(
  "${COMMON_ARGS[@]}"
  "--tempfs" "/run"
  "--tempfs" "/var/run"
  "--privileged"
  "--requires" "k3s-server"
)
NODE_ARGS=(
  "${WORKER_ARGS[@]}"
  "--publish" "31000-32000:31000-32000"
)


echo "Server:" "${SERVER_ARGS[@]}"
echo "Worker:" "${WORKER_ARGS[@]}"
echo "Node:  " "${NODE_ARGS[@]}"

# podman volume create k3s-server-volume
podman network create k3s-network

# podman kube generate
podman --cgroup-manager cgroupfs kube play --replace --cgroupns host --network k3s-network k3s.yml


# --hostname
# --name
# --pod-id-file
# --secret