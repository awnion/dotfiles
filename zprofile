## vim:ft=bash:
__ZPROFILE=1
echo "Loading ~/.zprofile"

# make snap work
# https://askubuntu.com/questions/910821/programs-installed-via-snap-not-showing-up-in-launcher/989485#989485
# emulate sh -c 'source /etc/profile'
# emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

PATH=/usr/local/sbin:"$PATH"
PATH=/usr/local/bin:"$PATH"

# nvm support
export NVM_DIR="$HOME"/.nvm

# pyenv support
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

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

  # llvm
  PATH=/opt/homebrew/opt/llvm/bin:"$PATH"

  # PATH=/opt/homebrew/opt/libtool/libexec/gnubin:"$PATH"
  # PATH=/opt/homebrew/opt/make/libexec/gnubin:"$PATH"

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

# bun + completions
export BUN_INSTALL="$HOME"/.bun
PATH="$BUN_INSTALL"/bin:"$PATH"
#
[[ -s "$HOME"/_bun ]] && source "$HOME"/_bun

# deno
PATH="$HOME"/.deno/bin:"$PATH"

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# uvx or pipx support
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

# Antigravity
PATH=$HOME/.antigravity/antigravity/bin:"$PATH"

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
PATH="$WASMTIME_HOME/bin:$PATH"

PATH=/opt/homebrew/opt/uutils-coreutils/libexec/uubin:"$PATH"

# ~/bin always overrides everything
PATH="$HOME"/bin:"$PATH"


# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
#
# export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/readline/lib/pkgconfig:$PKG_CONFIG_PATH"

export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"

export PATH

# # brew + ruby fix: https://github.com/rails/rails/issues/38560
# export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# export DISABLE_SPRING=true

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
