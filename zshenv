#!/bin/zsh
LANG=en_US.UTF-8
LC_ALL=$LANG

# Personal things (hidden from public repository)
if [[ -f $HOME/.personal ]]; then
    source $HOME/.personal
fi

# GEOS_DIR=/usr/local/Cellar/geos/3.7.1_1/

# Path
typeset -gxU path
path+=(
$HOME/bin
$HOME/.local/bin
$HOME/.local/share/bin
$HOME/.cargo/bin
#$HOME/.rustup/toolchains/nightly-*/bin
# $HOME/.rustup/toolchains/*/bin
#/usr/local/opt/python@*/bin
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
if [ -z rustc ]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Perl
# PATH="/Users/nilsso/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/Users/nilsso/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/Users/nilsso/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/Users/nilsso/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/Users/nilsso/perl5"; export PERL_MM_OPT;

# Lua
#typeset -T -gxU LUA_PATH lua_path ";"
#lua_path+=(
#$HOME/.luarocks/share/lua/5.1
#"$HOME/.luarocks/share/lua/5.1/?.lua"
#)
#export LUA_PATH

