# my dotfiles

The two major dependencies for my dotfiles are zsh and rcm.

The first, zsh, which is just an improved unix shell. There are many like it but I like this one.

The second, rcm, is the rc file (dotfile) management command suite by Thoughtbot, a.k.a. [rcm][rcm], which needs to be installed to somewhere for your path variable for the suite of commands (rcup, rcdn, mkrc and lsrc) to be picked up by your shell.

(TODO: Add short rcm installation instructions here)

All the suite does is add and remove symbolic-links (symlinks) from the configuration files in ~/.dotfiles to your home directory. For example the configuration file for the rcm suite is named rcrc and exists at ~/.dotfiles/rcrc; after running rcup the following file will exist: ~/.rcrc which points to ~/.dotfiles/rcrc. This way all configuration related files owned by the user can be stored in a single directory (~/.dotfiles) and be used as a git repository.

## Installing rcm

1.  Install [rcm][rcm]

2.  Clone this repository to ~/.dotfiles:
```
git clone https://github.com/SweedJesus/dotfiles.git ~/.dotfiles
```

3.  Run the rcup command with the variable RCRC set to the path of ~/.dotfiles/rcrc:
```
env RCRC=~/.dotfiles/rcrc rcup
```

This will symlink the various files and also run a couple scripts that will install various plugins for both vim and zsh.

4.  Set zsh as your login shell
```
chsh -s $(which zsh) $(USER)
```

[rcm]: https://github.com/thoughtbot/rcm

## Language servers

### GraphQL

```
npm install -g graphql-language-service-cli
```
