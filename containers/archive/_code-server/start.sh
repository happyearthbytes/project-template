podman network create develop_network
mkdir -p ~/.local/share/code-server
podman play kube --network develop_network run.k.yml 