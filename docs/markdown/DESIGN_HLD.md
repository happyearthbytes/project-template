
# System Design

## Install CONOPS

### STAGE-0: bootstrap the process

```bash
make setup-bootstrap
```

* [x] Start: No prerequisites
* [x] Performs: online install of git and clone a repo
* [ ] Performs: download a local archive of podman and IDE                      <!-- TODO: skipped OSX -->
* [ ] Produces: A local repository containing scripts (0)                       <!-- TODO: skipped OSX -->
* [ ] Produces: A local archive of podman and IDE (0)                           <!-- TODO: skipped OSX -->

### STAGE-1: generate archives with prerequisites

* [ ] Start: A local repository, podman archive, IDE archive (0)                <!-- TODO: skipped OSX -->
* [ ] Performs: Install Podman and IDE from local archive (0)                   <!-- TODO: manual  OSX -->
* [ ] Performs: Use podman to download a podman archive to an image             <!-- TODO: skipped OSX -->
* [ ] Performs: Use podman to download a IDE archive to an image                <!-- TODO: skipped OSX -->
* [ ] Performs: Use podman to download a repo archive to an image               <!-- TODO: skipped OSX -->
* [ ] Performs: Use podman image to extract podman archive locally (1)          <!-- TODO: skipped OSX -->
* [ ] Performs: Use IDE image to extract IDE archive locally (1)                <!-- TODO: skipped OSX -->
* [ ] Performs: Use repo image to extract repo archive locally (1)              <!-- TODO: skipped OSX -->
* [ ] Produces: local archives with podman, IDE, repo, gitlab (1)               <!-- TODO: skipped OSX -->

### STAGE-2: setup CI/CD to generate and host prerequisites (online)

* [ ] Start: A local repository, podman archive, IDE archive (1)                <!-- TODO: skipped OSX -->
* [ ] Performs: Install Podman and IDE from local archive (1)                   <!-- TODO: skipped OSX -->
* [ ] Performs: Use Podman to start gitlab container (1)                        <!-- TODO:  -->
* [ ] Performs: Use gitlab to generate standard prerequisites in CI/CD (2)      <!-- TODO:  -->
* [ ] Performs: Use gitlab to generate additional prerequisites in CI/CD (2)    <!-- TODO:  -->
* [ ] Produces: hosted prerequisites in CI/CD (2)                               <!-- TODO:  -->

### STAGE-3: set up a k3s cluster on an air-gapped system

* [ ] Start: A local repository, podman archive, IDE archive (2)                <!-- TODO:  -->
* [ ] Performs: Install Podman and IDE from local archive (2)                   <!-- TODO:  -->
* [ ] Performs: Start a cluster from k3s image (2)                              <!-- TODO:  -->
* [ ] Performs: Register new cluster nodes from ansible image (2)               <!-- TODO:  -->
* [ ] Performs: Ansible installs podman on the nodes                            <!-- TODO:  -->
* [ ] Performs: Ansible starts k3s agent container with podman                  <!-- TODO:  -->
* [ ] Produces: A cluster with server and agent nodes (3)                       <!-- TODO:  -->

### STAGE-4: have integrated DSO environment on an air-gapped system

* [ ] Start: A cluster with server and agent nodes (3)                          <!-- TODO:  -->
* [ ] Performs: Set up CI/CD pipelines in accordance with repo templates        <!-- TODO:  -->
