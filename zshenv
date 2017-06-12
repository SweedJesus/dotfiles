#!/usr/zsh

#echo -e "$(tput bold).zshenv$(tput sgr0)"

# Mesa Linux Server
export FIRE_PUBLIC=/var2/home/fire_public
export FIRE_HOSTNAME="209.129.16.61"
export FIRE_SSH_HOSTNAME="$FIRE_HOSTNAME"
export DPARILLO="/var2/home/dparillo"

export LS_OPTIONS='-F --color=auto --block-size=M -h'

# Ruby
export GEM_HOME="~/.gem/ruby/2.0.0"

# System
if [ -e ~/.terminfo/x/xterm-256color-it ]; then
    export TERM="xterm-256color-it"
else
    export TERM="xterm-256color"
fi
export EDITOR=/usr/bin/vim

#export PATH=$PATH:/usr/hla:/var2/local/bin:/var2/lopt/bin:$FIRE_PUBLIC/bin:$FIRE_PUBLIC/gem/ruby/2.0.0/bin

#export MANPATH=$MANPATH:$FIRE_PUBLIC/share/man

# C/C++
export CPATH=~/include:$FIRE_PUBLIC/include
export LIBRARY_PATH=$HOME/lib
export LARCH_PATH=/usr/share/splint/lib
export CXXFLAGS="-std=c++11 -Wall -Wextra -Wpedantic"

# Wemux
export WEMUX_DIR=$FIRE_PUBLIC/share/wemux
export WEMUX=$WEMUX_DIR/wemux
export WEMUX_CONFIG=$WEMUX_DIR/wemux.conf
