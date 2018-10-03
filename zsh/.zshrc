[[ ! -d $HOME/.zsh.d ]] && mkdir $HOME/.zsh.d
[[ ! -f $HOME/.zsh.d/antigen.zsh ]] && curl -sL -o $HOME/.zsh.d/antigen.zsh https://git.io/antigen

source $HOME/.zsh.d/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOB
  chriskempson/base16-shell
  docker
  git
  golang
  rsync
  rust
  z

  gpg-agent
  ssh-agent

  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search

  mafredri/zsh-async
EOB

if [[ "$OSTYPE" == "darwin11.0" ]]; then
  antigen bundle brew
  antigen bundle iterm2
  antigen bundle osx
fi

antigen theme sindresorhus/pure

antigen apply

RPROMPT="%F{white}$(kubectl config current-context)"

# Enable direnv
eval "$(direnv hook zsh)"

# History substring search plugin settings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
  source $HOME/.zshrc-private
fi

alias k=kubectl
alias kc=kubectx
alias kcp='kubectx -'
