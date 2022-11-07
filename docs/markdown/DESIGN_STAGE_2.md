
# STAGE-2: setup CI/CD to generate and host prerequisites (online)

## Start: A local repository, podman archive, IDE archive (1)

## Performs: Install Podman and IDE from local archive (1)

```bash
./setup.sh --type online-cicd
# - OR -
make setup-online-cicd
# - OR -
make setup ARGS="--type online-cicd"
```

* Use package manager to install IDE / Podman from local archive

## Performs: Use Podman to start gitlab container (1)

* podman run gitlab

## Performs: Use gitlab to generate standard prerequisites in CI/CD (2)

* TODO - automate gitlab provisioning
* MANUAL - set up gitlab and create pipeline for repo

## Performs: Use gitlab to generate additional prerequisites in CI/CD (2)

* gitlab pipeline runs based in CI/CD rules

## Produces: hosted prerequisites in CI/CD (2)

* gitlab pipeline automatically generates and hosts artifacts on gitlab
