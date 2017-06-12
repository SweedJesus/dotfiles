#!/bin/zsh

#echo -e "$(tput bold).zprofile$(tput sgr0)"

export LANG=en_US.utf8

typeset -gxU path
path=(\
  ~/.gem/ruby/2.2.0/bin\
  ~/.npm-global/bin\
  ~/.yarn-global/bin\
  $path)

typeset -gxU manpath
manpath=(\
  $manpath)
