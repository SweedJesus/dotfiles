# my dotfiles

First and foremost

```bash
git clone https://github.com/SweedJesus/dotfiles.git ~/.dotfiles
```

## Installing rcm

The `rcm` tool is one I ran accross when looking for ways to automate the setting-up and
tearing-downof my dotfiles, quickly and on any machine. It does this by symlinking everything in the
designated dotfiles directory (for me `~/.dotfiles`) into home. Files and folders at the first level
are all prepended with a dot, e.g. `~/.dotfiles/zshrc` is linked to `~/.zshrc`. Additionally, pre
and post-symlink hooks can be used for further automating the setup.

1. Install [`rcm`][rcm]
    (something like <kbd>sudo apt-get install rcm</kbd> or <kbd>brew install rcm</kbd>)

2. Run the <kbd>rcup</kbd> command with the variable `RCRC` set to the path of `~/.dotfiles/rcrc`

    ```bash
    env RCRC=~/.dotfiles/rcrc rcup
    ```

    This will symlink the various files and also run a couple scripts that will install various plugins
    for both neovim and zsh.

3. Install `zsh` and set it as your login shell

    ```bash
    chsh -s $(which zsh) $(USER)
    ```

[rcm]: https://github.com/thoughtbot/rcm

## Python

### Python versions and virtual environments

Both [`pyenv`][pyenv] for managing Python versions and [`pyenv-virtualenv`][pyenv-virtualenv] for
managing Python virtual environments. See [this][intro-to-pyenv] for a pretty good guide.

[intro-to-pyenv]: https://realpython.com/intro-to-pyenv/

To create a virtualenv for the Python version used with `pyenv`
run <kbd>pyenv virtualenv [version] \<venv-name\></kbd>. For example

[pyenv]: https://github.com/pyenv/pyenv
[pyenv-virtualenv]: https://github.com/pyenv/pyenv-virtualenv

```bash
pyenv virtualenv 2.7.10 my-virtual-env-2.7.10
```

If there is only one argument given to `pyenv virtualenv`, the virtualenv will be created with the
given name based on the current `pyenv` Python version.

If `eval "$(pyenv virtualenv-init -)"` is configured in your shell (which it is in `.zprofile`),
`pyenv-virtualenv` will automatically activate/deactivate virtualenvs on entering/leaving
directories which contain a `.python-version` file that contains the name of a valid virtual
environment as shown in the output of `pyenv virtualenvs` (e.g., `venv34` or `3.4.3/envs/venv34` in
example above) . `.python-version` files are used by pyenv to denote local Python versions and can
be created and deleted with the `pyenv local` command.

### Setup for neovim

Following [this guide][]

[this guide]: https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments

