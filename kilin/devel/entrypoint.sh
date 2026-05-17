#!/bin/bash
set -e

# Switch shell to zsh if available
if command -v zsh >/dev/null 2>&1; then
    ZSH_PATH=$(which zsh)
    chsh -s "$ZSH_PATH" 2>/dev/null || true
    export SHELL="$ZSH_PATH"
fi

# Write default .zshrc if user doesn't have one
if [[ ! -f "$HOME/.zshrc" ]]; then
    cat > "$HOME/.zshrc" << 'EOF'
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -z "$ZSH" ]]; then
    if [[ -d "/usr/local/bin/ohmyzsh" ]]; then
        export ZSH="/usr/local/bin/ohmyzsh"
    elif [[ -d "$HOME/.oh-my-zsh" ]]; then
        export ZSH="$HOME/.oh-my-zsh"
    fi
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(git)
source $ZSH/oh-my-zsh.sh
EOF
fi

exec "$@"
