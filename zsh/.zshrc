export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="dracula"

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(docker git kubectl oc osx ssh-agent z)

zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_funio

source $ZSH/oh-my-zsh.sh

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

# chruby
if hash chruby 2>/dev/null; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-2.3.0
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi

