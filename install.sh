#!/bin/bash

mkdir -p ~/bin
mkdir -p ~/.vim/sessions

cp .bashrc .conkyrc .vimrc .gitconfig .npmrc .tmux.conf ~/
cp -R bin ~/

# Arch Linux pacman hook to only keep the latest two versions of a package
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
sudo -i cp $SCRIPTPATH/20-remove-cache-packages.hook /etc/pacman.d/hooks
