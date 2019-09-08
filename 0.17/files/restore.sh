#!/usr/bin/env bash
C=${1:-${FDK_DEFAULT_RCLONE_CONFIG}}
X=RCLONE_CONFIG_${C}_REMOTE_PATH
TARGET="${C}:${!X}"

printf "\n\e[1;34m%-6s\e[m\n" "Restoring /opt/factorio from ${TARGET}"
mkdir -p /opt/factorio
rclone copy -P --create-empty-src-dirs "${TARGET}/config" ${CONFIG} -P --create-empty-src-dirs
rclone copy -P --create-empty-src-dirs "${TARGET}/saves" ${SAVES} -P --create-empty-src-dirs
rclone copy -P --create-empty-src-dirs "${TARGET}/config" ${MODS} -P --create-empty-src-dirs

printf "\n\e[1;34m%-6s\e[m\n" "Available saves:"
ls -w 1 ${SAVES}
