
# System Design

## CONOPS / Usecases

### Stage-B: bootstrap the process

* Start: No prerequisites
* Performs: online install of git and clone a repo
* Performs: download a local archive of podman and IDE
* Produces: A local repository containing scripts (B)
* Produces: A local archive of podman and IDE (B)

### STAGE-0: generate archives with prerequisites

* Start: A local repository, podman archive, IDE archive (B)
* Performs: Install Podman and IDE from local archive (B)
* Performs: Use podman to download a podman archive to an image
* Performs: Use podman to download a IDE archive to an image
* Performs: Use podman to download a repo archive to an image
* Performs: Use podman image to extract podman archive locally (0)
* Performs: Use IDE image to extract IDE archive locally (0)
* Performs: Use repo image to extract repo archive locally (0)
* Produces: local archives with podman, IDE, repo, gitlab (0)

### STAGE-1: setup CICD to generate and host prerequisites (online)

* Start: A local repository, podman archive, IDE archive (0)
* Performs: Install Podman and IDE from local archive (0)
* Performs: Use Podman to start gitlab container (0)
* Performs: Use gitlab to generate standard prerequisites in CICD (1)
* Performs: Use gitlab to generate additional prerequisites in CICD (1)
* Produces: hosted prerequisites in CICD (1)

### STAGE-2: setup CICD to generate prerequisites

* Start: A local repository, podman archive, IDE archive (1)
* Performs: Install Podman and IDE from local archive (1)
* Performs: Start a cluster from k3s image (1)
* Performs: Register new cluster nodes from ansible image (1)
* Performs: Ansible installs podman on the nodes
* Performs: Ansible starts k3s agent container with podman
* Produces: A cluster with server and agent nodes
