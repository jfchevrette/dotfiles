zmodload zsh/zprof
[[ ! -d $HOME/.zsh.d ]] && mkdir $HOME/.zsh.d
[[ ! -f $HOME/.zsh.d/antigen.zsh ]] && curl -sL -o $HOME/.zsh.d/antigen.zsh https://git.io/antigen

source $HOME/.zsh.d/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOB
  chriskempson/base16-shell
  docker
  fzf
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

# Right prompt that shows kube context
function kube_prompt() {
  RPROMPT="%F{white}$(kubectl config current-context)"
}
precmd_functions+=kube_prompt

alias k=kubectl
alias kc=kubectx
alias kcp='kubectx -'

alias time=/usr/bin/time
export TIME="\t%e real\t%U user\t%S sys"

# asdf - https://github.com/asdf-vm/asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Linuxbrew.sh
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# direnv
eval "$(direnv hook zsh)"

# fzf
# Auto-completion
[[ $- == *i* ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings
source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh"
# Use fd instead of find
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
h() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
  source $HOME/.zshrc-private
fi

