#!/bin/zsh

#echo -e "$(tput bold).zshrc$(tput sgr0)"

# Aliases
try_source ~/.aliases

# Talk permission
mesg y

# Default file permission
umask 022

# Turn of history expansion
#setopt no_bang_hist
#setopt no_prompt_bang

# Solarized dircolors
#eval `dircolors ~/.dir_colors`

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Antigen and plugins
source ~/.antigen/antigen.zsh
if ! [[ -v ANTIGEN_LOADED ]]; then
  antigen init ~/.antigenrc
  ANTIGEN_LOADED=True
fi
