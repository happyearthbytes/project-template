
# System Design

## Install CONOPS

### STAGE-0: bootstrap the process

* Start: No prerequisites
* Performs: online install of git and clone a repo
* Performs: download a local archive of podman and IDE
* Produces: A local repository containing scripts (0)
* Produces: A local archive of podman and IDE (0)

### STAGE-1: generate archives with prerequisites

* Start: A local repository, podman archive, IDE archive (0)
* Performs: Install Podman and IDE from local archive (0)
* Performs: Use podman to download a podman archive to an image
* Performs: Use podman to download a IDE archive to an image
* Performs: Use podman to download a repo archive to an image
* Performs: Use podman image to extract podman archive locally (1)
* Performs: Use IDE image to extract IDE archive locally (1)
* Performs: Use repo image to extract repo archive locally (1)
* Produces: local archives with podman, IDE, repo, gitlab (1)

### STAGE-2: setup CI/CD to generate and host prerequisites (online)

* Start: A local repository, podman archive, IDE archive (1)
* Performs: Install Podman and IDE from local archive (1)
* Performs: Use Podman to start gitlab container (1)
* Performs: Use gitlab to generate standard prerequisites in CI/CD (2)
* Performs: Use gitlab to generate additional prerequisites in CI/CD (2)
* Produces: hosted prerequisites in CI/CD (2)

### STAGE-3: set up a k3s cluster on an air-gapped system

* Start: A local repository, podman archive, IDE archive (2)
* Performs: Install Podman and IDE from local archive (2)
* Performs: Start a cluster from k3s image (2)
* Performs: Register new cluster nodes from ansible image (2)
* Performs: Ansible installs podman on the nodes
* Performs: Ansible starts k3s agent container with podman
* Produces: A cluster with server and agent nodes (3)

### STAGE-4: have integrated DSO environment on an air-gapped system

* Start: A cluster with server and agent nodes (3)
* Performs: Set up CI/CD pipelines in accordance with repo templates
