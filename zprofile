__ZPROFILE=1
echo "Loading ~/.zprofile"

if [[ -d /home/linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

##############################
# paths
##############################
PATH=/usr/local/sbin:"$PATH"
PATH=/usr/local/bin:"$PATH"

# use GNU coreutils by their default names (e.g. dircolors)
# break `ls` compatibility
PATH=/usr/local/opt/coreutils/libexec/gnubin:"$PATH"

# ruby
PATH=/usr/local/opt/ruby/bin:"$PATH"

# rust
PATH="$HOME"/.cargo/bin:"$PATH"

# pipx support
PATH="$HOME"/.local/bin:"$PATH"

# tondev
PATH="$HOME"/.tondev/bin:"$PATH"
PATH="$HOME"/pro/ton/tonos-cli/target/release:"$PATH"

# ~/bin always overrides everything
PATH="$HOME"/bin:"$PATH"

export PATH
