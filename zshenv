#!/bin/zsh

LANG=en_US.UTF-8
LC_ALL=$LANG
DEFAULT_USER=nils

# Misc
Website=~/Documents/Web/nilsso.github.io

# School and classes
School=~/Documents/School/2019-Spring

# 2018-Fall
#408=$School/../2018-Fall/MUSIC-408
#320=$School/../2018-Fall/MATH-320
#330=$School/../2018-Fall/MATH-330
#340=$School/../2018-Fall/MATH-340

# 2019-Spring
496=$School/../2019-Spring/CS-496
524=$School/../2019-Spring/MATH-524
530=$School/../2019-Spring/MATH-530
596=$School/../2019-Spring/MATH-596
308=$School/../2019-Spring/MUSIC-308

EDORAS=cssc0699@edoras.sdsu.edu

#Research=~/Documents/School/Research/acm
ACM=~/Documents/School/Research/acm/acm-cpp/

# Path
typeset -gxU path
path+=(
~/bin
#~/bin/gap-4.10.0
~/.gem/ruby/*/bin
#~/Documents/Python/quiz-generator
)

# Manpath
typeset -gxU manpath
manpath+=(
$manpath
)

# User functions
fpath=(~/.zfunc/ "${fpath[@]}")
autoload -Uz try_source

# Python virtualenv
#VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3 
#VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
#source /usr/local/bin/virtualenvwrapper.sh

#eval "$(jenv init -)"
