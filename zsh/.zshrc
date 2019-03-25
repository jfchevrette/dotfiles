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
if [[ "$(uname -s)" == "Darwin" ]]; then
  PROMPT='$(~/bin/prompt-darwin) \$ '
else
  PROMPT='$(~/bin/prompt-linux) \$ '
fi

if [[ -f ~/.kube/config ]]; then
fi

function kube_prompt() {
  echo "%F{white}$(awk '/^current-context:/ {print $2}' ~/.kube/config)"
}
function git_prompt() {
  local ok_color=2
  local err_color=1
  local white_color=7
  local statc="%{\e[0;3${ok_color}m%}" # assume clean
  local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

  if [ -n "$bname" ]; then
    local rs="$(git status --porcelain -b)"
    if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
      statc="%{\e[0;3${err_color}m%}"
    elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
      statc="%{\e[0;3${err_color}m%}"
    elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
      statc="%{\e[0;3${white_color}m%}"
    elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
      statc="%{\e[0;3${white_color}m%}"
    else # is clean
      statc="%{\e[0;3${ok_color}m%}"
    fi
    echo -n "$statc$bname%{\e[0m%}"
  fi
}
PROMPT='$(~/bin/prompt) \$ '
RPROMPT='$(git_prompt) $(kube_prompt)'

# History
function myhistory {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    echo >&2 History file deleted. Reload the session to see its effects.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}
alias history='myhistory'
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

# SSH agent
if [[ -z "${SSH_AGENT_PID}" ]]; then
  if ! [[ -e /tmp/ssh-agent-$USER ]]; then
    ssh-agent 2>/dev/null >/tmp/ssh-agent-$USER
  fi
  . /tmp/ssh-agent-$USER >/dev/null
fi

# Copy/Paste
alias pbcopy=xclip -i -selection clipboard
alias pbpaste=xclip -o -selection clipboard

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

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
  exec dbus-launch --sh-syntax --exit-with-session sway
fi
