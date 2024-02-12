# Dotfiles

A few files for setting up bash and Vim in different environments. Also includes a couple of scripts that make a few things easier.

 * `bin`
   * `fixShareCopy` resets file and directory permissions recursively for a directory copied into a VM from a host share (also useful to just set file and directory permissions to sane defaults). Use it as `fixShareCopy copiedDirOrFileName`.
   * `pkgBackup` generates a list of all installed packages (for an Arch Linux install) to make VM setups easier.
   * `shortdir` is used by `../.bashrc` to shorten directory paths that are longer than desired for the prompt.
   * `weather.py` is used by conky as configured in `../.conkyrc`.
   * `wmux` creates or joins a 'web' tmux session with a window for the project name given (edit this to set your project path).
 * `.bashrc` provides aliased commands, includes `/home/$USER/bin` in the path, and customizes the command line.
 * `.conkyrc` provides a configuration setup for [conky](https://wiki.archlinux.org/index.php/conky) which relies on files in `bin`.
 * `.vimrc` sets up Vim with several useful things (auto-installs [vim-plug](https://github.com/junegunn/vim-plug)), just open Vim and run `:PlugInstall` to get all the plugins loaded.
 * `.gitconfig` sets up my user and a couple of helpful aliases (edit this for your git user).
 * `.npmrc` use local directory `~/.npm-global` for global packages.
 * `.tmux.conf` sets up tmux configuration including Powerline-styled status line.
 * `pacman.conf` configures the Arch Linux package manager pacman.
 * `20-remove-cache-packages.hook` is a pacman hook to only keep the latest two versions in the package cache.

 To use everything, just run `install.sh` from within the `dotfiles` directory. To selectively use things, it's as easy as copying the files you want to the chosen destination.

 If you use `gnome-terminal` and want the terminal colors to match the Vim colors, also run `base16-eighties-256.sh`, then open a new terminal and choose the profile for that color scheme.

