#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
BACKUP_ROOT="$DOTFILES_DIR/_backups/$(date +%Y%m%d-%H%M%S)"
BACKUP_CREATED=0
APPLY_MACOS_DEFAULTS=0

usage () {
  printf 'Usage: %s [--macos-defaults]\n' "${0##*/}"
}

for argument in "$@"; do
  case "$argument" in
    --macos-defaults) APPLY_MACOS_DEFAULTS=1 ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$argument" >&2
      usage >&2
      exit 2
      ;;
  esac
done

backup_target () {
  local target="$1"
  local relative backup

  relative="${target#"$HOME"/}"
  backup="$BACKUP_ROOT/$relative"
  mkdir -p "$(dirname -- "$backup")"
  mv -- "$target" "$backup"
  BACKUP_CREATED=1
  printf 'Backed up %s -> %s\n' "$target" "$backup"
}

link_item () {
  local source="$1"
  local target="$2"

  if [[ ! -e "$source" ]] && [[ ! -L "$source" ]]; then
    printf 'Missing source: %s\n' "$source" >&2
    return 1
  fi

  if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]]; then
    return 0
  fi

  if [[ -e "$target" ]] || [[ -L "$target" ]]; then
    backup_target "$target"
  fi

  mkdir -p "$(dirname -- "$target")"
  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

apply_macos_defaults () {
  [[ "${OSTYPE:-}" == darwin* ]] || return 0

  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
  defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write -g InitialKeyRepeat -int 15
  defaults write -g KeyRepeat -int 1
}

link_item "$DOTFILES_DIR/bash_profile" "$HOME/.bash_profile"
link_item "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
link_item "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
link_item "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
link_item "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"
link_item "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

link_item "$DOTFILES_DIR/config/alacritty" "$HOME/.config/alacritty"
link_item "$DOTFILES_DIR/config/gitignore_global" "$HOME/.config/gitignore_global"
link_item "$DOTFILES_DIR/config/htop" "$HOME/.config/htop"
link_item "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
link_item "$DOTFILES_DIR/config/sheldon" "$HOME/.config/sheldon"
link_item "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
link_item "$DOTFILES_DIR/config/zed/settings.json" "$HOME/.config/zed/settings.json"

legacy_lesscolors="$HOME/.config/lesscolors.sh"
if [[ -L "$legacy_lesscolors" ]] &&
   [[ "$(readlink "$legacy_lesscolors")" == "$DOTFILES_DIR/config/lesscolors.sh" ]]; then
  rm -- "$legacy_lesscolors"
  printf 'Removed stale link %s\n' "$legacy_lesscolors"
fi

link_item "$DOTFILES_DIR/bin/colorless" "$HOME/bin/colorless"

if (( APPLY_MACOS_DEFAULTS )); then
  apply_macos_defaults
fi

if (( BACKUP_CREATED )); then
  printf 'Backups saved under %s\n' "$BACKUP_ROOT"
fi
