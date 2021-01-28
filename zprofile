__ZPROFILE=1
echo "Loading ~/.zprofile"

if [[ -d /home/linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
