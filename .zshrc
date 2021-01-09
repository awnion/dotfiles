echo "Loading ~/.zshrc"


# paths 
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH


# settings
export BAT_THEME=OneHalfLight
export HIST_FIND_NO_DUPS=1
setopt HIST_FIND_NO_DUPS
export ZSH_HIGHLIGHT_MAXLENGTH=200
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export SOBOLE_THEME_MODE=light
export ZSH_COMMAND_TIME_MIN_SECONDS=1


alias ipy='ipython3'


# antigen
source /usr/local/share/antigen/antigen.zsh
antigen reset
antigen use oh-my-zsh
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

zstyle ':autocomplete:tab:*' widget-style menu-complete # circular Tab and Shift-Tab for completion
zstyle ':autocomplete:*' min-delay .3  # 300 milliseconds
