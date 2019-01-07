zmodload zsh/zprof
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

  taskwarrior

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

# Taskwarrior config file
export TASKRC=$HOME/.config/task/config

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
  source $HOME/.zshrc-private
fi

alias k=kubectl
alias kc=kubectx
alias kcp='kubectx -'

alias time=/usr/bin/time
export TIME="\t%e real\t%U user\t%S sys"

function todo() {
  # Print taskwarrior todos
  if hash task 2>/dev/null; then
    task next
  fi

  # Print today's CalDav appointments
  #if hash khal 2>/dev/null; then
  #  khal agenda
  #fi
}
todo

# asdf - https://github.com/asdf-vm/asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
