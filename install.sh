#!/bin/bash

mkdir -p ~/bin
mkdir -p ~/.vim/sessions

cp .bashrc .conkyrc .vimrc .gitconfig .npmrc .tmux.conf ~/
cp -R bin ~/
