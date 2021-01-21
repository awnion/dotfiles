echo "Loading ~/.zshrc"

export KEYTIMEOUT=1

# paths
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=$HOME/.gem/ruby/3.0.0/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# settings
export BAT_THEME=OneHalfLight
export ZSH_HIGHLIGHT_MAXLENGTH=200
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_COMMAND_TIME_MIN_SECONDS=1

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

source ~/.config/pager_config.sh

alias ipy='ipython3'
function weather() {
  clear
  echo "Weather $1 $2"
  curl "http://wttr.in/${1:-}?${2:-TF0nq}"
}
alias wt=weather
alias wr=weather
alias vi=nvim
alias vim=nvim

# Vim
export VISUAL=nvim
export EDITOR="$VISUAL"

# antigen
[[ ! -d "$HOME/.config/antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.config/antigen"
source "$HOME/.config/antigen/antigen.zsh"
# antigen reset
antigen use oh-my-zsh
antigen bundle marlonrichert/zsh-autocomplete
antigen bundle django
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle pip
antigen bundle tmux

# antigen bundle zsh_reload
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle popstas/zsh-command-time

if [[ "$OSTYPE" == "darwin"* ]]; then
  antigen bundle osx
fi

antigen apply

# settings for marlonrichert/zsh-autocomplete
zstyle ':autocomplete:tab:*' insert-unambiguous yes     # make Tab first insert any common substring, before inserting full completion
zstyle ':autocomplete:tab:*' widget-style menu-complete # circular Tab and Shift-Tab for completion
zstyle ':autocomplete:*' min-delay .3
zstyle ':autocomplete:*' key-binding off

# full list of vars: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
PROMPT=$'%{$fg[blue]%}%D{[%X]}%f %{$fg[white]%}%~%f $(git_prompt_info)[%?]%f\
%# '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# time function format 
TIMEFMT=$'\n\nCPU\t%P\nuser\t%*U\nsys\t%*S\ntotal\t%*E'
