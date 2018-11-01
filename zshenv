#!/bin/zsh

# Misc
Website=~/Documents/Web/nilsso.github.io

# School and classes
School=~/Documents/School/2018-Fall
408=$School/MUSIC-408
320=$School/MATH-320
330=$School/MATH-330
340=$School/MATH-340

LC_ALL=en_US.utf8
LANG=en_US.utf8
DEFAULT_USER=nils

# Path
typeset -gxU path
path+=(
~/bin
~/.gem/ruby/2.5.0/bin
~/Documents/Python/quiz-generator
)

# Manpath
typeset -gxU manpath
manpath+=(
$manpath)

# User functions
fpath=(~/.zfunc/ "${fpath[@]}")
autoload -Uz try_source

# Python virtualenv
#VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3 
#VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
#source /usr/local/bin/virtualenvwrapper.sh

#eval "$(jenv init -)"
