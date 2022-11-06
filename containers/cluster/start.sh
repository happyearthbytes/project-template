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
  "--volume" "k3s-server-volume:/var/lib/rancher/k3s"
  "--volume" ".:/output"
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
#

# podman pod create --cgroup-parent=host --name k3s-pod
# podman pod create --name k3s-pod
podman network create k3s-network
podman run --env-file .env --replace --name k3s-server --rm \
  --detach \
  --stop-timeout 3 --timeout 1000 --network k3s-network \
  --volume k3s-server-volume:/var/lib/rancher/k3s \
  --volume "${PWD}":/output \
  --publish 6443:6443 \
                   --privileged --cgroupns=host k3s:server server \
  --token aaa \
  --disable-agent \
  --config /output/kubeconfig.yaml \
  --write-kubeconfig-mode "666" --node-name k3s-server
# podman run --env-file .env --replace --name k3s-worker --rm \
#   --detach \
#   --requires k3s-server \
#   --stop-timeout 3 --timeout 1000 --network k3s-network --tmpfs /run \
#   --tmpfs /var/run --privileged --cgroupns=host k3s:worker agent \
#   --token aaa --server https://k3s-server:6443
podman run --env-file .env --replace --name k3s-worker --rm \
  --detach \
  --requires k3s-server \
  --stop-timeout 3 --timeout 1000 --network k3s-network --tmpfs /run \
  --tmpfs /var/run --privileged --cgroupns=host --entrypoint '' k3s:worker sleep 10000


# While I tried to get this to work on OSX, the inability to modify the podman
# cgroupns made this tricky to get to work
# podman kube play --replace --network k3s-network --userns=host k3s.yml

# podman run --env-file .env --replace --name k3s-worker --rm --stop-timeout 3 --timeout 1000 --network k3s-network --tmpfs /run --tmpfs /var/run --privileged k3s:worker
# podman run --env-file .env --replace --name k3s-worker --rm --stop-timeout 3 --timeout 1000 --network k3s-network --tmpfs /run --tmpfs /var/run --privileged --cgroupns=host k3s:worker agent --token 1


# Docker Desktop now uses cgroupv2. If you need to run systemd in a container then:
# - Ensure your version of systemd supports cgroupv2. It must be at least systemd 247. Consider upgrading any centos:7 images to centos:8.
# - Containers running systemd need the following options: --privileged --cgroupns=host -v /sys/fs/cgroup:/sys/fs/cgroup:rw.
