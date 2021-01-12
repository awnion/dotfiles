#!/bin/bash

set -e
DOTFILES_DIR=$(pwd)


if [[ "$OSTYPE" == "darwin"* ]]; then
    # enable key repeating in specific apps on MacOS
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
    defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
    defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false    # For VS Codium
    # defaults delete -g ApplePressAndHoldEnabled                                      # If necessary, reset global default
fi

(cd ~; rm -rf .gitconfig; ln -s $DOTFILES_DIR/.gitconfig .gitconfig)
(cd ~/.config/alacritty; rm -rf alacritty.yml; ln -s $DOTFILES_DIR/alacritty.yml alacritty.yml)
(cd ~; rm -rf .tmux.conf; ln -s $DOTFILES_DIR/.tmux.conf .tmux.conf)
(cd ~; rm -rf .vimrc; ln -s $DOTFILES_DIR/.vimrc .vimrc)
(cd ~; rm -rf .zshrc; ln -s $DOTFILES_DIR/.zshrc .zshrc)
(cd ~/.config; rm -rf wezterm; ln -s $DOTFILES_DIR/wezterm wezterm)
