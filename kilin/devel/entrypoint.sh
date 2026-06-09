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
if [[ -n "$ZSH" ]]; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    plugins=(git)
    source $ZSH/oh-my-zsh.sh
fi
EOF
fi

# Only manage persistent host keys when the host_keys volume is mounted
if [[ -d /etc/ssh/host_keys ]]; then
    # Generate SSH host keys if not exist, otherwise copy from host_keys to /etc/ssh
    if [[ ! -f /etc/ssh/host_keys/ssh_host_rsa_key ]]; then
        sudo ssh-keygen -A
        sudo cp /etc/ssh/ssh_host_* /etc/ssh/host_keys/
    else
        sudo cp /etc/ssh/host_keys/ssh_host_* /etc/ssh/
    fi
fi

# sshd config test
sudo /usr/sbin/sshd -t

# sshd in background
sudo /usr/sbin/sshd -e

exec "$@"
