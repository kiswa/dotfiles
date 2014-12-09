## Dotfiles

A few files for setting up bash and Vim in different environments. Also includes a couple of scripts that make a few things easier.

 * `.vimrc` sets up Vim with several useful things, just open Vim and run `:PluginInstall` to get all the plugins loaded (Assumes [Vundle](https://github.com/gmarik/Vundle.vim) is installed)
 * `.bashrc` includes `\home\$USER\bin` and __Ruby__ in the path, and customizes the command line
 * `bin`
  * `fixShareCopy` resets file and folder permissions for a directory copied into a VM from a host share(also useful to just set file and directory permissions to sane defaults). Use it as `fixShareCopy copiedDirName`.
  * `spinupWebsite` uses the files in the `swFiles` directory and creates a site setup with __Bootstrap__ and __Font Awesome__. It also uses __Gulp__, __Bower__ and __npm__ to load everything needed. Use it as `spinupWebsite newSiteName` to get a directory `newSiteName` ready to go.
