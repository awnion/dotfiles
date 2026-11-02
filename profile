# ~/.profile: read only by POSIX sh login shells (`sh -l`).
# zsh reads ~/.zprofile and bash reads ~/.bash_profile, so neither uses this file.
# The full environment lives there; keep this POSIX and minimal.

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -r "$HOME/.deno/env" ]; then . "$HOME/.deno/env"; fi
if [ -r "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi

PATH="$HOME/.local/bin:$PATH"
if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
export PATH
