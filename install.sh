#!/usr/bin/env bash

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

  # make repeat speed lighting fast
  defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
fi

(
  cd "$HOME" || exit
  rm -rf .gitconfig
  rm -rf .tmux.conf
  rm -rf .vimrc
  rm -rf .zprofile
  rm -rf .zshrc
  ln -s "$DOTFILES_DIR/gitconfig" .gitconfig
  ln -s "$DOTFILES_DIR/tmux.conf" .tmux.conf
  ln -s "$DOTFILES_DIR/vimrc" .vimrc
  ln -s "$DOTFILES_DIR/zprofile" .zprofile
  ln -s "$DOTFILES_DIR/zshrc" .zshrc
)

mkdir -p "$HOME/.config"
(
  cd "$HOME/.config" || exit
  rm -rf alacritty
  rm -rf htop
  rm -rf gitignore_global
  rm -rf lesscolors.sh
  rm -rf nvim
  rm -rf wezterm
  rm -rf starship.toml
  ln -s "$DOTFILES_DIR/config/alacritty" alacritty
  ln -s "$DOTFILES_DIR/config/htop" htop
  ln -s "$DOTFILES_DIR/config/gitignore_global" gitignore_global
  ln -s "$DOTFILES_DIR/config/lesscolors.sh" lesscolors.sh
  ln -s "$DOTFILES_DIR/config/nvim" nvim
  ln -s "$DOTFILES_DIR/config/wezterm" wezterm
  ln -s "$DOTFILES_DIR/config/starship.toml" starship.toml
  ln -s "$DOTFILES_DIR/config/zoomus.conf" zoomus.conf
)

mkdir -p "$HOME/bin"
(
  cd "$HOME/bin" || exit
  rm -rf colorless
  ln -s "$DOTFILES_DIR/bin/colorless" colorless
  chmod +x colorless
)
