#!/bin/bash

set -e
DOTFILES_DIR=$(pwd)

(cd ~; rm -rf .gitconfig; ln -s $DOTFILES_DIR/.gitconfig .gitconfig)
