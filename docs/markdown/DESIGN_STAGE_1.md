
# STAGE-1: generate archives with prerequisites

## Start: A local repository, podman archive, IDE archive (0)

## Performs: Install Podman and IDE from local archive (0)

* Use package manager to install IDE and Podman from local archive

## Performs: Use podman to download a podman archive to an image

```bash
make download-online-deps
# - OR -
make download ARGS="--type online-deps"
```

* Select base OS based on install target
* Download Podman in image

## Performs: Use podman to download a IDE archive to an image

* Select base OS based on install target
* Download IDE in image

## Performs: Use podman to download a repo archive to an image

* Select git base OS
* Download repo in image

## Performs: Use podman image to extract podman archive locally (1)

* Use podman to copy Podman archive from image to localhost

## Performs: Use IDE image to extract IDE archive locally (1)

* Use podman to copy IDE archive from image to localhost

## Performs: Use repo image to extract repo archive locally (1)

* Use podman to copy IDE archive from image to localhost

## Produces: local archives with podman, IDE, repo, gitlab (1)

* localhost now has all prerequisite install files that were produced in a
  fully repeatable and OS agnostic manner
