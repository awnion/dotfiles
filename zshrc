echo "Loading ~/.zshrc"
if [[ -z "$__ZPROFILE" ]]; then
  source $HOME/.zprofile
fi


##############################
# history
##############################
export HISTFILE="$HOME/.cache/zsh/zhistory"
export HISTSIZE=10000000
export SAVEHIST=10000000
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


##############################
# antigen
##############################
if [[ ! -d "$HOME/.config/antigen" ]]; then
  git clone https://github.com/zsh-users/antigen.git "$HOME/.config/antigen"
fi
source "$HOME/.config/antigen/antigen.zsh"
antigen use oh-my-zsh

# sometimes buggy/laggy
# antigen bundle marlonrichert/zsh-autocomplete
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle django
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
# antigen bundle git-prompt
antigen bundle pip
antigen bundle tmux
antigen bundle fd
antigen bundle fzf

# doesn't work properly with zsh-autocomplete (yet)
# antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle popstas/zsh-command-time
if [[ "$OSTYPE" == "darwin"* ]]; then
  antigen bundle osx
fi

antigen apply

# settings for marlonrichert/zsh-autocomplete
# zstyle ':autocomplete:tab:*' insert-unambiguous no     # if `yes` make Tab first insert any common substring, before inserting full completion
# zstyle ':autocomplete:tab:*' widget-style menu-complete # circular Tab and Shift-Tab for completion
zstyle ':autocomplete:*' min-delay .3
# zstyle ':autocomplete:*' key-binding off

# Esc timeout for vi mode
export KEYTIMEOUT=1


##############################
# paths
##############################
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
# use GNU coreutils by their default names (e.g. dircolors)
# break `ls` compatibility
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
# ~/bin always overrides everything
export PATH="$HOME/bin:$PATH"


##############################
# prompt
##############################
if [[ -x "$(which starship)" ]]; then
  eval "$(starship init zsh)"
else
  # full list of vars: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  PROMPT=$'\
  %B%(?..%F{red})[$(printf "%03d" $?)]%b %F{white}%D{[%X]}%f %B%~%b $(git_super_status)%F{magenta}%B$(python_venv)%b%f\
  %B>>> %b'

  # never use right prompt
  RPROMPT=''

  ZSH_THEME_GIT_PROMPT_PREFIX="%F{cyan}%B"
  ZSH_THEME_GIT_PROMPT_SUFFIX=" "
  ZSH_THEME_GIT_PROMPT_BRANCH=" "
  ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
fi

# TODO: generalize mb?
# export VIRTUAL_ENV_DISABLE_PROMPT=1
function python_venv {
  if [[ ! -z "$VIRTUAL_ENV" ]]; then
    echo -ne "$VIRTUAL_ENV" | sed -E 's:.*/([^/]+/[^/]+)$:(\1):'
  fi
}


##############################
# Vim
##############################
alias vi=nvim
alias vim=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"


##############################
# Pagers
##############################
# This affects every invocation of `less`.
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x#  tabs are # instead of 8
#   -j#  skip first # lines from the top of the screen then search
export LESS="-ij5RFXMx4 --mouse --wheel-lines=2"
# change hist file location
export LESSHISTFILE=$HOME/.cache/lesshst
export PAGER='colorless'
export MANPAGER='colorless'
alias less='colorless'


##############################
# FZF settings
##############################
export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND='fd -t d . $HOME'
# export FZF_ALT_C_COMMAND="fd -t d . $HOME"
# generator here https://minsw.github.io/fzf-color-picker/
# !! replaces terminal background !!
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#555555,bg:#fafafa,hl:#ff4747"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg+:#2e2e2e,bg+:#eaeaea,hl+:#ff0000"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=info:#ac84ad,prompt:#ff0000,pointer:#008cff"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=marker:#cc62cc,spinner:#5c61ff,header:#5d9191"

function f {
  new_dir="\
    $(fd -H -I -E .git -t d \
    | fzf --preview='ls --color=always -gGhFA --group-directories-first {}')"
  if [[ ! -z "$new_dir" ]]; then
    cd $base_dir/$new_dir
  fi
}
# alias fh='f ~'


##############################
# random settings
##############################
alias ':q'='exit'
# Turns on colors with default unix `ls` command:
export CLICOLOR=1

# ls colors could be generated here: https://geoff.greer.fm/lscolors/
# but seems like GNU dircolors with GNU ls is better
# setup LS_COLORS
eval "$(dircolors -b)"
export LSCOLORS="exfxcxdxBxegedabagacab"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# TODO: refactor this
alias ls='ls --color=always -FCA'
alias rm='rm -i'
export BAT_THEME=OneHalfLight
export ZSH_HIGHLIGHT_MAXLENGTH=200
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_COMMAND_TIME_MIN_SECONDS=1

# time function format
# bash style time
export TIMEFMT=$'\n\nCPU\t%P\nuser\t%*U\nsys\t%*S\ntotal\t%*E'
# smart cd
function cd {
  builtin cd $@ && \
  COLUMNS=$(tput cols) ls --color=always -FCA | tail -5
}

# python
export IPYTHONDIR=$HOME/.config/ipython

# python venv trick
function venv {
  local -a venv_cases
  venv_cases+=( ".venv/bin/activate" )
  venv_cases+=( "venv/bin/activate" )
  for v in $venv_cases; do
    if [[ -z "$VIRTUAL_ENV" ]] && [[ -f $v ]]; then
      . "$v"
      echo "activate $v"
    fi
  done
}
alias createvenv='python3 -m venv --prompt "$pwd:h:t" .venv'
alias cvenv='createvenv'

alias p=ipython3
alias py=ipython3
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
    echo "$(tput setab $i)Bcolor$i$(tput sgr0) $(tput setaf $i)Fcolor$i$(tput sgr0) $(tput setab $i)$(tput setaf 15)BFcolor$i$(tput sgr0) $(tput setab $i)$(tput setaf 8)BFcolor$i$(tput sgr0)"
  done
}
