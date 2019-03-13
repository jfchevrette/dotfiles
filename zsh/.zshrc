zmodload zsh/zprof
[[ ! -d $HOME/.zgen ]] && git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen" 

export ZGEN_RESET_ON_CHANGE=($HOME/.zshrc)
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen load mafredri/zsh-async
  zgen load peterhurford/git-it-on.zsh
  zgen load rupa/z
  #zgen load sindresorhus/pure
  zgen load unixorn/autoupdate-zgen
  zgen load zdharma/fast-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen save
fi

# Prompt
setopt prompt_subst
PROMPT='$(~/bin/prompt) \$ '
if [[ -f ~/.kube/config ]]; then
  RPROMPT="%F{white}$(awk '/^current-context:/ {print $2}' ~/.kube/config)"
fi

# History
alias history='history -i'
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Fix Home/End/Delete
bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward

# exa
if hash exa 2> /dev/null; then alias ls='exa -alghH --git'; fi

# colored cat
if hash ccat 2> /dev/null; then alias cat=ccat; fi

# prefer GNU sed b/c BSD sed doesn't handle whitespace the same
if hash gsed 2> /dev/null; then alias sed=gsed; fi

alias o=oc
alias k=kubectl
alias kc=kubectx

alias time=/usr/bin/time
export TIME="\t%e real\t%U user\t%S sys"

# direnv
#eval "$(direnv hook zsh)"
_direnv_hook() {
  eval "$(direnv export zsh)";
}
typeset -ag precmd_functions;
if hash direnv 2> /dev/null; then
  if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
    precmd_functions+=_direnv_hook;
  fi
fi

# fzf
[[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source "/usr/share/fzf/shell/key-bindings.zsh"

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
  source $HOME/.zshrc-private
fi
