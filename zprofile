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

# make snap work
# https://askubuntu.com/questions/910821/programs-installed-via-snap-not-showing-up-in-launcher/989485#989485
if type snap; then
    emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'
fi

# ruby
if [[ -d /home/linuxbrew ]]; then
    PATH=/home/linuxbrew/.linuxbrew/opt/ruby/bin:"$PATH"
else
    PATH=/usr/local/opt/ruby/bin:"$PATH"
fi

# rust
PATH="$HOME"/.cargo/bin:"$PATH"
PATH="$HOME"/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/:"$PATH"

# pipx support
PATH="$HOME"/.local/bin:"$PATH"

# tondev
PATH="$HOME"/.tondev/bin:"$PATH"
PATH="$HOME"/pro/ton/tonos-cli/target/release:"$PATH"

# ~/bin always overrides everything
PATH="$HOME"/bin:"$PATH"

export PATH

# nvm support
export NVM_DIR="$HOME"/.nvm
