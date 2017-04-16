# my dotfiles

For use with the *rc file (dotfile) management* command suite by Thoughtbot: **[rcm][rcm]**. Needs to be installed to somewhere for your path variable to pick up the suite of commands: *rcup*, *rcdn*, *mkrc* and *lsrc*.

All the suite does is add and remove symbolic-links (symlinks) from the configuration files in *~/.dotfiles* to your home directory. For example the configuration file for the rcm suite is named *rcrc* and exists at *~/.dotfiles/rcrc*; after running *rcup* the following file will exist: *~/.rcrc* which points to *~/.dotfiles/rcrc*. This way all configuration related files owned by the user can be stored in a single directory (*~/.dotfiles*) and be used as a git repository.

## Installation

1.  Install [rcm][rcm]

2.  Clone this repository to *~/.dotfiles*:

    ```
    git clone https://github.com/SweedJesus/dotfiles.git ~/.dotfiles
    ```

3.  Run the *rcup* command with the variable *RCRC* set to the path of *~/.dotfiles/rcrc*:

    ```
    env RCRC=~/.dotfiles/rcrc rcup
    ```

    This will symlink the various files and also run a couple scripts that will install various plugins for both vim and zsh.

4.  Set zsh as your login shell

    ```
    chsh -s $(which zsh) $(USER)
    ```

    *zsh* is just an improved unix shell. There are many like it but I like this one.

[rcm]: https://github.com/thoughtbot/rcm
