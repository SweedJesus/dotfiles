#!/bin/zsh

LANG=en_US.UTF-8
LC_ALL=$LANG

source $HOME/.personal

GEOS_DIR=/usr/local/Cellar/geos/3.7.1_1/

# Path
typeset -gxU path
path+=(
$HOME/bin
$HOME/.cargo/bin
$HOME/.gem/ruby/*/bin
$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/bin
/Library/Ruby/Gems/2.6.0/gems/*/bin
/usr/local/opt/python@*/bin
/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/
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

# C++
export CXX=clang++

# Rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Lua
#typeset -T -gxU LUA_PATH lua_path ";"
#lua_path+=(
#$HOME/.luarocks/share/lua/5.1
#"$HOME/.luarocks/share/lua/5.1/?.lua"
#)
#export LUA_PATH

# Python virtualenv
#VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3 
#VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
#source /usr/local/bin/virtualenvwrapper.sh

#eval "$(jenv init -)"
