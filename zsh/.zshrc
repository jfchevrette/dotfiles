export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(docker git osx ssh-agent z)

zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_funio

source $ZSH/oh-my-zsh.sh

# Exports
export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export MANPATH="/usr/local/man:$MANPATH"
export GOPATH="$HOME/code/go"
export PATH="$GOPATH/bin:$PATH"

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
alias emacs='open -a /Applications/Emacs.app $1'
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"

# Rust/cargo
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH=$HOME/code/rust/src

# chruby
if hash chruby 2>/dev/null; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-2.3.0
fi

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi
