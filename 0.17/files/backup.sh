#!/usr/bin/env bash
C=${1:-${FDK_DEFAULT_RCLONE_CONFIG}}
X=RCLONE_CONFIG_${C}_REMOTE_PATH
TARGET="${C}:${!X}"

printf "\n\e[1;34m%-6s\e[m\n" "Storing /opt/factorio as ${TARGET}"
mkdir -p /opt/factorio
rclone copy -P --create-empty-src-dirs ${CONFIG} "${TARGET}/config" -P --create-empty-src-dirs
rclone copy -P --create-empty-src-dirs ${SAVES} "${TARGET}/saves" -P --create-empty-src-dirs
rclone copy -P --create-empty-src-dirs ${MODS} "${TARGET}/config" -P --create-empty-src-dirs

printf "\n\e[1;34m%-6s\e[m\n" "Stored saves:"
ls -w 1 ${SAVES}
