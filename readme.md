## Dotfiles

A few files for setting up bash and Vim in different environments, as well as some X environment files. Also includes a couple of scripts that make a few things easier.

 * `bin`
  * `fixShareCopy` resets file and directory permissions recursively for a directory copied into a VM from a host share (also useful to just set file and directory permissions to sane defaults). Use it as `fixShareCopy copiedDirName`.
  * `spinupWebsite` uses the files in the `swFiles` directory and creates a base website dev setup. Use it as `spinupWebsite newSiteName [framework]` to get a directory `newSiteName` ready to go.
    * Frameworks available: __None__, __Bootstrap (SASS)__, or __Bourbon__ & __Neat__.
    * Uses __Bower__ and __npm__ to load everything needed, __Ruby sass__ for SASS compiling, and __Gulp__ for building.
    * Includes __fb-flo__ for live reloading.
  * `conky_bg.lua`, `notify.py`, and `weather.py` are all used by conky as configured in `../.conkyrc`.
  * `pkgBackup` generates a list of all installed packages (for an Arch install) to make VM setups easier.
 * `.bashrc` includes `\home\$USER\bin` and __Ruby__ in the path, and customizes the command line.
 * `.conkyrc` provides a configuration setup for [conky](https://wiki.archlinux.org/index.php/conky) which relies on files in `bin`.
 * `.vimrc` sets up Vim with several useful things, just open Vim and run `:PluginInstall` to get all the plugins loaded (Assumes [Vundle](https://github.com/gmarik/Vundle.vim) is installed).
