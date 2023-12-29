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
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
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
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# rust
PATH="$HOME"/.cargo/bin:"$PATH"
# PATH="$HOME"/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/:"$PATH"

# go
PATH="$HOME"/go/bin:"$PATH"

# bun completions
[[ -s "/Users/aw/.bun/_bun" ]] && source "/Users/aw/.bun/_bun"

# pipx support
PATH="$HOME"/.local/bin:"$PATH"

# # tondev
# PATH="$HOME"/.tondev/bin:"$PATH"
# PATH="$HOME"/pro/ton/tonos-cli/target/release:"$PATH"

PATH=/opt/homebrew/opt/postgresql@15/bin:"$PATH"

# GOSH
PATH="$HOME"/.gosh:"$PATH"

# ~/bin always overrides everything
PATH="$HOME"/bin:"$PATH"

export PATH
