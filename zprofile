__ZPROFILE=1
echo "Loading ~/.zprofile"

if [[ -d /home/linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

##############################
# paths
##############################
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# use GNU coreutils by their default names (e.g. dircolors)
# break `ls` compatibility
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# haskell
export PATH="$HOME/.cabal/bin:$PATH"

# pipx support
# export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# tondev
export PATH="$HOME/.tondev/bin:$PATH"
export PATH="$HOME/pro/ton/tonos-cli/target/release:$PATH"

# ~/bin always overrides everything
export PATH="$HOME/bin:$PATH"
