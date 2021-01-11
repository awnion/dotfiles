echo "Loading ~/.zshrc"


# paths
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH


# settings
export BAT_THEME=OneHalfLight
export SOBOLE_THEME_MODE=light
export ZSH_HIGHLIGHT_MAXLENGTH=200
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_COMMAND_TIME_MIN_SECONDS=1

HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# Pagers:
# This affects every invocation of `less`.
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS="-iRFXMx4 --mouse --wheel-lines=2"
export PAGER='less'
export MANPAGER='less'


alias ipy='ipython3'


# antigen
source /usr/local/share/antigen/antigen.zsh
antigen reset
antigen use oh-my-zsh
antigen bundle django
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle pip
# antigen bundle zsh_reload
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle marlonrichert/zsh-autocomplete

antigen bundle popstas/zsh-command-time

# May be useful
# antigen bundle command-not-found
# antigen bundle web-search
# antigen bundle zsh-navigation-tools

if [[ "$OSTYPE" == "darwin"* ]]; then
    antigen bundle osx
fi

antigen theme sobolevn/sobole-zsh-theme

antigen apply

# settings for marlonrichert/zsh-autocomplete
zstyle ':autocomplete:tab:*' insert-unambiguous yes     # make Tab first insert any common substring, before inserting full completion
zstyle ':autocomplete:tab:*' widget-style menu-complete # circular Tab and Shift-Tab for completion
zstyle ':autocomplete:*' min-delay .3  # 300 milliseconds
