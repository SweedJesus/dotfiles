#!/bin/zsh

# Talk permission
mesg y

# Default file permission
umask 022

# Colorscheme (pywal)
[[ $ITERM_PROFILE != "Asciinema" ]] && ((cat ~/.cache/wal/sequences); clear)

# Turn of history expansion
#setopt no_bang_hist
#setopt no_prompt_bang

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Theme config
POWERLEVEL9K_MODE='nerdfont-complete'
if [[ $ITERM_PROFILE = "Asciinema" ]]; then
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
else
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status root_indicator background_jobs todo history time)
  POWERLEVEL9K_TODO_BACKGROUND="blue"
fi

# Solarized dircolors
#eval `dircolors ~/.dir_colors`

# Antigen and plugins
source ~/.antigen/antigen.zsh
if ! [[ -v ANTIGEN_LOADED ]]; then
  antigen init ~/.antigenrc
  ANTIGEN_LOADED=True
fi

# Aliases
try_source ~/.aliases

# iTerm profiles (asciimedia)
if [[ $ITERM_PROFILE = "Asciinema" ]]; then
  unalias ls
fi
