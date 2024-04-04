#!/bin/bash

set -euo pipefail

EXTRA_ARGS=()

# Borrowed from: https://github.com/flathub/md.obsidian.Obsidian/blob/5312e50f13f48efccd60a90f282b92b38bcec9a1/obsidian.sh#L20
WL_DISPLAY="${WAYLAND_DISPLAY:-"wayland-0"}"
# Some compositors a real path a instead of a symlink for WAYLAND_DISPLAY:
# https://github.com/flathub/md.obsidian.Obsidian/issues/284
if [[ -e "${XDG_RUNTIME_DIR}/${WL_DISPLAY}" || -e "/${WL_DISPLAY}" ]]; then
    echo "Debug: Enabling Wayland backend"
    EXTRA_ARGS+=(
        --ozone-platform-hint=auto
        --enable-features=WaylandWindowDecorations
        --enable-wayland-ime
    )
    if [[ -c /dev/nvidia0 ]]; then
        echo "Debug: Detecting Nvidia GPU. disabling GPU sandbox."
        EXTRA_ARGS+=(
            --disable-gpu-sandbox
        )
    fi
fi

exec zypak-wrapper.sh /app/termius/termius-app "${EXTRA_ARGS[@]}" "$@"
