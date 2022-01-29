#!/bin/zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Default file permission
umask 022

# Colorscheme (pywal)
#((cat ~/.cache/wal/sequences); clear)

# Turn of history expansion
#setopt no_bang_hist
#setopt no_prompt_bang

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Personal private things (hidden from public repository)
# TODO: secret protected in repository?
if [[ -f $HOME/.zprivate ]]; then
    source $HOME/.zprivate
fi

# Aliases
source ~/.aliases

# User functions
fpath=(~/.zfunc/ "${fpath[@]}")
autoload -Uz try_source

# Python
eval "$(pyenv init -)"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Antigen and plugins
source ~/.antigen/antigen.zsh
if [[ ! -v ANTIGEN_LOADED ]]; then
    antigen init ~/.antigenrc
    ANTIGEN_LOADED=1
fi

# Theme (p10k) config. To customize, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
