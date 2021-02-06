__ZPROFILE=1
echo "Loading ~/.zprofile"

if [[ -d /home/linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# pipx support
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
