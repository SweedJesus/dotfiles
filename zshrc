#!/bin/zsh

# Talk permission
mesg y

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

# Theme config
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs todo history time)
#POWERLEVEL9K_TODO_BACKGROUND="blue"

# Antigen and plugins
source ~/.antigen/antigen.zsh
#if ! [[ -v ANTIGEN_LOADED ]]; then
antigen init ~/.antigenrc
ANTIGEN_LOADED=True
#fi

# Aliases
source ~/.aliases

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
