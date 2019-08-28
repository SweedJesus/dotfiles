#!/bin/zsh

LANG=en_US.UTF-8
LC_ALL=$LANG
DEFAULT_USER=nils

# Misc
Website=~/Documents/Web/nilsso.github.io

# School and classes
School=~/Documents/School/2019-Fall

OPHELIA=olsson@ophelia2.sdsu.edu
alias ophelia='ssh $OPHELIA'

Research=~/Documents/School/Research
acm=$Research/acm

GEOS_DIR=/usr/local/Cellar/geos/3.7.1_1/

# Path
typeset -gxU path
path+=(
$HOME/bin
$HOME/.cargo/bin
$HOME/.gem/ruby/*/bin
#$HOME/bin/gap-4.10.1
#/Users/nilsso/Library/Python/2.7/bin
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

function acp {
  git add -A;
  git commit -m '$1';
  git push;
}

# Rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Python virtualenv
#VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3 
#VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
#source /usr/local/bin/virtualenvwrapper.sh

#eval "$(jenv init -)"
