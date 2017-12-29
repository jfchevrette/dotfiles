export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="dracula"

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(docker git osx ssh-agent)

zstyle :omz:plugins:ssh-agent identities id_rsa

source $ZSH/oh-my-zsh.sh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Generic Colourizer (https://github.com/garabik/grc)
if [[ -f "/usr/local/etc/grc.bashrc" ]]; then
    source "/usr/local/etc/grc.bashrc"
fi

# FZF
export FZF_DEFAULT_OPTS='--no-mouse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias g="git"
alias h="history"
alias wttr='curl -s wttr.in'
alias bmon='bmon -p wlp3s0,enp0s25 -o "curses:fgchar=S;bgchar=.;nchar=N;uchar=?;details"'
alias ip='ip -c'

cheat() { curl cheat.sh/$1; }
qrcode() { echo $@ | curl -F-=\<- qrenco.de; }

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi

