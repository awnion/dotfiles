## vim:ft=bash:
__ZPROFILE=1
echo "Loading ~/.zprofile"

# make snap work
# https://askubuntu.com/questions/910821/programs-installed-via-snap-not-showing-up-in-launcher/989485#989485
emulate sh -c 'source /etc/profile'
# emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

PATH=/usr/local/sbin:"$PATH"
PATH=/usr/local/bin:"$PATH"

# nvm support
export NVM_DIR="$HOME"/.nvm

# pyenv support
export PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## linux
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

## mac os
if [[ -d /opt/homebrew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

## mac os
if [[ -d /opt/homebrew ]]; then
  ## mac only
  # use GNU coreutils by their default names (e.g. dircolors)
  # break `ls` compatibility
  if [[ -d /opt/homebrew/opt/coreutils/libexec/gnubin ]]; then
    PATH=/opt/homebrew/opt/coreutils/libexec/gnubin:"$PATH"
  fi

  ## TODO: make it work
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
fi

if [[ -n "$HOMEBREW_PREFIX" ]]; then
  # ruby
  PATH="$HOMEBREW_PREFIX"/opt/ruby/bin:"$PATH"
fi

#nix
# PATH=/nix/var/nix/profiles/default/bin:"$PATH"
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# rust
PATH="$HOME"/.cargo/bin:"$PATH"

# zig + zvm
export ZVM_INSTALL="$HOME"/.zvm/self
PATH="$ZVM_INSTALL":"$PATH"
PATH="$HOME"/.zvm/bin:"$PATH"

# go
PATH="$HOME"/go/bin:"$PATH"

# pnpm
export PNPM_HOME="$HOME"/Library/pnpm
PATH="$PNPM_HOME":"$PATH"

# bun + completions
export BUN_INSTALL="$HOME"/.bun
PATH="$BUN_INSTALL"/bin:"$PATH"
#
[[ -s "$HOME"/_bun ]] && source "$HOME"/_bun

# deno
PATH="$HOME"/.deno/bin:"$PATH"

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# pipx support
PATH="$HOME"/.local/bin:"$PATH"

# android studio
export ANDROID_HOME=$HOME/Library/Android/sdk
PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/platform-tools

# GOSH
PATH="$HOME"/.gosh:"$PATH"

# Added by Windsurf
PATH="$HOME"/.codeium/windsurf/bin:"$PATH"

# RustRover
PATH="/Applications/RustRover.app/Contents/MacOS":"$PATH"

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
PATH="$WASMTIME_HOME/bin:$PATH"

# ~/bin always overrides everything
PATH="$HOME"/bin:"$PATH"

export PATH

# brew + ruby fix: https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export DISABLE_SPRING=true
