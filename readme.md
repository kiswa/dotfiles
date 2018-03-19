## Dotfiles

A few files for setting up bash and Vim in different environments. Also includes a couple of scripts that make a few things easier.

 * `bin`
  * `fixShareCopy` resets file and directory permissions recursively for a directory copied into a VM from a host share (also useful to just set file and directory permissions to sane defaults). Use it as `fixShareCopy copiedDirName`.
  * `weather.py` is used by conky as configured in `../.conkyrc`.
  * `pkgBackup` generates a list of all installed packages (for an Arch install) to make VM setups easier.
 * `.bashrc` includes `\home\$USER\bin` and __Ruby__ in the path, and customizes the command line (to include displaying active branch in git repos).
 * `.conkyrc` provides a configuration setup for [conky](https://wiki.archlinux.org/index.php/conky) which relies on files in `bin`.
 * `.vimrc` sets up Vim with several useful things, just open Vim and run `:PlugInstall` to get all the plugins loaded (Assumes [vim-plug](https://github.com/junegunn/vim-plug) is installed).
 * `.gitconfig` sets up my user and a couple of helpful aliases (Edit this for your git user!)
 * `.npmrc` use local directory `~\.npm-global` for global packages (no sudo needed to install)
 * `.tmux.conf` sets up tmux configuration including Powerline-styled status line

 To use everything, just run `install.sh` from within the `dotfiles` directory. To selectively use things, it's as easy as copying the files you want to the chosen destination.

 If you use `gnome-terminal` and want the terminal colors to match the Vim colors, also run `base16-eighties-256.sh`, then open a new terminal and choose the profile for that color scheme.

