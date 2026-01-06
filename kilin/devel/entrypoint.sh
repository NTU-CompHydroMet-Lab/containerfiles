#!/bin/bash
set -e

# 嘗試切換 shell（但不強制）
if command -v zsh >/dev/null 2>&1; then
    ZSH_PATH=$(which zsh)
    chsh -s "$ZSH_PATH" 2>/dev/null || true
    export SHELL="$ZSH_PATH"
fi

exec "$@"
