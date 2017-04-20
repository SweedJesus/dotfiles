#!/bin/zsh

#echo -e "$(tput bold).zprofile$(tput sgr0)"

typeset -U path
path=(\
  /var2/home/fire_public/bin\
  /usr/hla /var2/local/bin /var2/lopt/bin\
  ${FIRE_PUBLIC}/gem/ruby/2.0.0/bin\
  $path)
export PATH

typeset -U manpath
manpath=(\
  /var2/home/file_public/share/man\
  $manpath)
export MANPATH

export GEM_HOME=${FIRE_PUBLIC}/gem/ruby/2.0.0
#export GEM_PATH=${FIRE_PUBLIC}/gem/ruby/2.0.0
