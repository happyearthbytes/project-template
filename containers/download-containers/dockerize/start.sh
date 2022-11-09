#!/usr/bin/env bash
podman run -it --rm \
--cap-add SYS_ADMIN \
--device /dev/fuse \
--security-opt apparmor:unconfined \
-v "${PWD}":/output \
-v "${PWD}":/input \
download:dockerize /bin/sh