#!/bin/zsh

LANG=en_US.utf8

DEFAULT_USER=nils

# Path
typeset -gxU path
path=(
/usr/local/share/wemux
~/.gem/ruby/2.2.0/bin
~/.npm-global/bin
~/.yarn-global/bin
$path)

# Manpath
typeset -gxU manpath
manpath=(
$manpath)

# User functions
fpath=(~/.zfunc/ "${fpath[@]}")
autoload -Uz try_source
