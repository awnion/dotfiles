#!/bin/bash

set -e
DOTFILES_DIR=$(pwd)

(cd ~; rm -rf .gitconfig; ln -s $DOTFILES_DIR/.gitconfig .gitconfig)
(cd ~/.config/alacritty; rm -rf alacritty.yml; ln -s $DOTFILES_DIR/alacritty.yml alacritty.yml)
(cd ~; rm -rf .tmux.conf; ln -s $DOTFILES_DIR/.tmux.conf .tmux.conf)
(cd ~; rm -rf .vimrc; ln -s $DOTFILES_DIR/.vimrc .vimrc)
(cd ~; rm -rf .zshrc; ln -s $DOTFILES_DIR/.zshrc .zshrc)
