# shellcheck shell=bash

# Load the complete Bash environment for interactive non-login shells too.
if [[ -z "${DOTFILES_BASH_PROFILE_LOADED:-}" ]] && [[ -r "$HOME/.bash_profile" ]]; then
  DOTFILES_BASHRC_LOADING_PROFILE=1
  source "$HOME/.bash_profile"
  unset DOTFILES_BASHRC_LOADING_PROFILE
fi

[[ $- == *i* ]] || return 0

if [[ -r "$HOME/.orbstack/shell/init.bash" ]]; then
  source "$HOME/.orbstack/shell/init.bash"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
