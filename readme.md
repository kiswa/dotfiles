## Dotfiles

A few files for setting up bash and Vim in different environments. Also includes a couple of scripts that make a few things easier.

 * `bin`
  * `fixShareCopy` resets file and directory permissions recursively for a directory copied into a VM from a host share (also useful to just set file and directory permissions to sane defaults). Use it as `fixShareCopy copiedDirName`.
  * `spinupWebsite` uses the files in the `swFiles` directory and creates a base website dev setup. Use it as `spinupWebsite newSiteName [framework]` to get a directory `newSiteName` ready to go.
    * Frameworks available: __None__, __Bootstrap (SASS)__, or __Bourbon__ & __Neat__.
      * Commands: `spinupWebsite newSiteName`, `spinupWebsite newSiteName Bootstrap`, and `spinupWebsite newSiteName Bourbon` respectively.
    * Uses __Bower__ and __npm__ to load everything needed, __Ruby sass__ for SASS compiling, and __Gulp__ for building.
    * Includes __fb-flo__ for live reloading (runs as part of `gulp watch` task).
  * `conky_bg.lua`, `notify.py`, and `weather.py` are all used by conky as configured in `../.conkyrc`.
  * `pkgBackup` generates a list of all installed packages (for an Arch install) to make VM setups easier.
 * `.bashrc` includes `\home\$USER\bin` and __Ruby__ in the path, and customizes the command line (to include displaying active branch in git repos).
 * `.conkyrc` provides a configuration setup for [conky](https://wiki.archlinux.org/index.php/conky) which relies on files in `bin`.
 * `.vimrc` sets up Vim with several useful things, just open Vim and run `:PluginInstall` to get all the plugins loaded (Assumes [Vundle](https://github.com/gmarik/Vundle.vim) is installed).

 To use everything, just run `install.sh`. To selectively use things, it's as easy as copying the files you want to the chosen destination.
