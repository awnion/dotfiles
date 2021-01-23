echo "Loading ~/.zshrc"

# history
HISTFILE="$HOME/.cache/zsh/zhistory"
HISTSIZE=10000000
SAVEHIST=10000000
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing nonexistent history.

# antigen
if [[ ! -d "$HOME/.config/antigen" ]]; then
  git clone https://github.com/zsh-users/antigen.git "$HOME/.config/antigen"
fi
source "$HOME/.config/antigen/antigen.zsh"
antigen reset
antigen use oh-my-zsh
antigen bundle marlonrichert/zsh-autocomplete
antigen bundle django
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle git-prompt
antigen bundle pip
antigen bundle tmux
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle popstas/zsh-command-time
if [[ "$OSTYPE" == "darwin"* ]]; then
  antigen bundle osx
fi

antigen apply

# settings for marlonrichert/zsh-autocomplete
zstyle ':autocomplete:tab:*' insert-unambiguous no     # if `yes` make Tab first insert any common substring, before inserting full completion
zstyle ':autocomplete:tab:*' widget-style menu-complete # circular Tab and Shift-Tab for completion
zstyle ':autocomplete:*' min-delay .3
zstyle ':autocomplete:*' key-binding off

export KEYTIMEOUT=1

# paths
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=$HOME/.gem/ruby/3.0.0/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# settings
BAT_THEME=OneHalfLight
ZSH_HIGHLIGHT_MAXLENGTH=200
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_COMMAND_TIME_MIN_SECONDS=1

# python venv trick
# TODO: generalize mb?
VIRTUAL_ENV_DISABLE_PROMPT=1
function python_venv {
  echo "${VIRTUAL_ENV:-}" | sed -E 's:.*/([^/]+/[^/]+)$:(\1) :'
}

# ? mb make standalone theme ?
# full list of vars: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PROMPT=$'[code = %?]\
%F{cyan}%D{[%X]}%f %~ $(git_super_status)\
%B%F{magenta}$(python_venv)%f%b%B%#%b '

# never use right prompt
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}%B "
ZSH_THEME_GIT_PROMPT_SUFFIX="%b"
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "

# time function format 
TIMEFMT=$'\n\nCPU\t%P\nuser\t%*U\nsys\t%*S\ntotal\t%*E'

alias ipy=ipython3
function weather() {
  clear
  echo "Weather $1 $2"
  curl "http://wttr.in/${1:-}?${2:-TF0nq}"
}
alias wt=weather
alias wr=weather
function color_table() {
  for i in $(seq 0 ${1:-20}); do 
    echo "$(tput setab $i)Bcolor$i$(tput sgr0)$(tput setaf $i)Fcolor$i$(tput sgr0)"
  done
}

# Vim
alias vi=nvim
alias vim=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"

# Pagers:
# This affects every invocation of `less`.
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x#  tabs are # instead of 8
#   -j#  skip first # lines from the top of the screen then search
export LESS="-ij5RFXMx4 --mouse --wheel-lines=2"
export PAGER="(. $HOME/.config/lesscolors.sh;less)"
export MANPAGER="(. $HOME/.config/lesscolors.sh;less)"
