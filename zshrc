#!/bin/zsh

#echo -e "$(tput bold).zshrc$(tput sgr0)"

# Talk permission
mesg y

# Default file permission
umask 022

# Turn of history expansion
#setopt no_bang_hist
#setopt no_prompt_bang

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Solarized dircolors
eval `dircolors ~/.dir_colors`

# Plugins
source ~/.antigen/antigen.zsh
antigen init ~/.antigenrc

# Plugin overrides
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0' # Grey
#export SPACESHIP_GIT_SHOW=false
#export SPACESHIP_PROMPT_SYMBOL='>'
export SPACESHIP_PROMPT_SYMBOL='➔'
export SPACESHIP_PREFIX_SHOW=false
export SPACESHIP_VI_MODE_SHOW=false

# Aliases
[[ -e ~/.aliases ]] && source ~/.aliases
[[ -e ~/.profile.local ]] && source ~/.profile.local
