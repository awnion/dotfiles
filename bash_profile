# Keep Bash login shells aligned with the Zsh login environment.
if [[ -r "$HOME/.zprofile" ]]; then
  source "$HOME/.zprofile"
fi
