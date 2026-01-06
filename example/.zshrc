if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -z "$ZSH" ]]; then
    if [[ -d "/usr/share/oh-my-zsh" ]]; then
        export ZSH="/usr/share/oh-my-zsh"
    elif [[ -d "$HOME/.oh-my-zsh" ]]; then
        export ZSH="$HOME/.oh-my-zsh"
    fi
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export TERM="xterm-256color"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
