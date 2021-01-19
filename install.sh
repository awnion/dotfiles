#!/bin/bash

# TODO: Maybe rewrite this on python??
#       check this: https://github.com/anishathalye/dotbot/blob/master/bin/dotbot

set -e
DOTFILES_DIR=$(pwd)

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Vim mode vscode and others
  # enable key repeating in specific apps on MacOS
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
  defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
  # defaults delete -g ApplePressAndHoldEnabled                                      # If necessary, reset global default
fi

(
  cd $HOME
  rm -rf .gitconfig
  rm -rf .tmux.conf
  rm -rf .vimrc
  rm -rf .zprofile
  rm -rf .zshrc
  ln -s $DOTFILES_DIR/gitconfig .gitconfig
  ln -s $DOTFILES_DIR/tmux.conf .tmux.conf
  ln -s $DOTFILES_DIR/vimrc .vimrc
  ln -s $DOTFILES_DIR/zprofile .zprofile
  ln -s $DOTFILES_DIR/zshrc .zshrc
)

mkdir -p $HOME/.config
(
  cd $HOME/.config
  rm -rf alacritty
  rm -rf wezterm
  rm -rf gitignore_global 
  ln -s $DOTFILES_DIR/config/alacritty alacritty
  ln -s $DOTFILES_DIR/config/wezterm wezterm
  ln -s $DOTFILES_DIR/config/gitignore_global gitignore_global
)
