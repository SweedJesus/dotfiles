#!/bin/zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Default file permission
umask 022

# Colorscheme (pywal)
#((cat ~/.cache/wal/sequences); clear)

# Turn of history expansion
#setopt no_bang_hist
#setopt no_prompt_bang

# Glob
setopt extended_glob

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Personal private things (hidden from public repository)
# TODO: secret protected in repository?
if [[ -f $HOME/.zprivate ]]; then
    source $HOME/.zprivate
fi

# Aliases
source ~/.aliases

# User functions
typeset -gxaU fpath
fpath+=(
    ~/.zfunc/ "${fpath[@]}"
    ${ZDOTDIR:-~}/.zsh_functions
)
autoload -Uz try_source

# Opens in a tmux session (auto-attach)
# [[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
#     [[ -n "$ATTACH_ONLY" ]] && {
#         tmux a 2>/dev/null || {
#             cd && exec tmux
#         }
#         exit
#     }
# 
#     tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
#     exec tmux
# }

# Python (pyenv)
eval "$(pyenv init -)"

# Perl stuff?
PATH="/home/nils/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/nils/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/nils/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/nils/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/nils/perl5"; export PERL_MM_OPT;

# yarn
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# pnpm
export PNPM_HOME="/Users/nils/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Antigen + OhMyZsh
# source ~/.antigen/antigen.zsh
source $(brew --prefix antigen)/share/antigen/antigen.zsh
if [[ ! -v ANTIGEN_LOADED ]]; then
    antigen init ~/.antigenrc
    ANTIGEN_LOADED=1
fi

# Theme (p10k) config. To customize, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
