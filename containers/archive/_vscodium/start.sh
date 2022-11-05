#!/usr/bin/env bash
podman run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri \
    -e DISPLAY \
    -e GDK_SCALE \
    -e GDK_DPI_SCALE \
    -e QT_DEVICE_PIXEL_RATIO \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v ${HOME}:${HOME} \
    -w ${PWD} \
    --security-opt label=disable \
    --userns=keep-id \
    --name vscodium \
    vscodium bash
