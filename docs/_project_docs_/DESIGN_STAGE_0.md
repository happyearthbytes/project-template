
# STAGE-0: bootstrap the process

## Start: No prerequisites

## Performs: online install of git and clone a repo

```bash
yum/dnf/apt/brew/etc.. install git
git clone <url>.git
```

## Performs: download a local archive of podman and IDE

```bash
make setup-bootstrap
# - OR -
./setup.sh --env bootstrap
# - OR -
make setup # Interactive select bootstrap
# - OR -
./setup.sh # Interactive select bootstrap
```

* Dynamically identify package manager with `bash` - TODO `sh`

## Produces: A local repository containing scripts (0)

* From original git clone

## Produces: A local archive of podman and IDE (0)

* Use package manager to do a local download of podman and IDE
