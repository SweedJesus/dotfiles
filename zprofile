#!/bin/zsh
# Common term settings
LANG=en_US.UTF-8
LC_ALL=$LANG

# Path (https://github.com/antonio/zsh-config/blob/master/help/typeset)
typeset -gxaU path
path+=(
    $HOME/bin
    $HOME/.local/bin
    $HOME/.local/share/bin
    $HOME/.cargo/bin
    $HOME/.poetry/bin
    $HOME/.config/yarn/global/node_modules/.bin
    /usr/local/Cellar/fontforge/20201107/bin
)

# Manpath
typeset -gxaU manpath
manpath+=()

# Python (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=0
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# C++
export CXX=clang++

# Rust
if [ -z rustc ]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
