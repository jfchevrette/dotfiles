# ~/.zshrc
#
#
# shellcheck disable=SC1090,SC2148

[[ ! -d $HOME/.zgen ]] && git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen" 
export ZGEN_RESET_ON_CHANGE=("${HOME}/.zshrc" "${HOME}/.zshenv")
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen load mafredri/zsh-async
  zgen load peterhurford/git-it-on.zsh
  zgen load rupa/z
  zgen load unixorn/autoupdate-zgen
  zgen load zdharma/fast-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen load jfchevrette/zsh-titles
  zgen save
fi

# Prompt
function kube_prompt() {
  #echo "%F{white}$(awk '/^current-context:/ {print $2}' ~/.kube/config)"
  echo "%F{white}$(kubectl config current-context)"
}
function git_prompt() {
  local ok_color=2
  local err_color=1
  local white_color=7
  local statc="%{\e[0;3${ok_color}m%}" # assume clean
  local bname
  
  bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  if [ -n "$bname" ]; then
    local rs

    rs="$(git status --porcelain -b)"
    if echo "$rs" | grep -v '^##' &> /dev/null; then # is dirty
      statc="%{\e[0;3${err_color}m%}"
    elif echo "$rs" | grep '^## .*diverged' &> /dev/null; then # has diverged
      statc="%{\e[0;3${err_color}m%}"
    elif echo "$rs" | grep '^## .*behind' &> /dev/null; then # is behind
      statc="%{\e[0;3${white_color}m%}"
    elif echo "$rs" | grep '^## .*ahead' &> /dev/null; then # is ahead
      statc="%{\e[0;3${white_color}m%}"
    else # is clean
      statc="%{\e[0;3${ok_color}m%}"
    fi
    echo -n "$statc$bname%{\e[0m%}"
  fi
}

setopt prompt_subst
PROMPT='$(~/bin/prompt-linux) ($(kube_prompt))$(git_prompt) \$ '
if [[ "$(uname -s)" == "Darwin" ]]; then
  PROMPT='$(~/bin/prompt-darwin) $(git_prompt) \$ '
fi

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
setopt hist_ignore_all_dups   # deleteold recorded entry if new entry is a duplicate
setopt hist_save_no_dups      # don't write duplicate entries in the history file
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt hist_reduce_blanks     # remove superfluous blanks before recording entry

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

# exa
if hash exa 2> /dev/null; then alias ls='exa -alghH --git'; fi
alias ll=ls -alsnew

# prefer GNU sed b/c BSD sed doesn't handle whitespace the same
if hash gsed 2> /dev/null; then alias sed=gsed; fi

alias o=oc
alias k=kubectl
alias kc=kubectx

alias time=/usr/bin/time
export TIME="\t%e real\t%U user\t%S sys"

# Private stuff
if [[ -e $HOME/.zshrc-private ]]; then
  source $HOME/.zshrc-private
fi

# Fix escape sequences from terminfo
typeset -A key
key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

export EDITOR=vim

# GPG stuff
GPG_TTY=$(tty)
export GPG_TTY

# GO
export GOROOT=$(go env GOROOT)

# Work related aliases
alias daily='/bin/cat ~/work/daily/daily-$(date "+%Y%m%d").txt'
alias vidaily='/usr/bin/vim ~/work/daily/daily-$(date "+%Y%m%d").txt'
alias todo='/bin/cat ~/work/todo.txt'

# Bitwarden
function bwunlock() {
  export BW_SESSION=$(bw unlock --raw)
}

# FZF
export FZF_DEFAULT_COMMAND="rg --one-file-system --files"
export FZF_DEFAULT_OPTS="--ansi --inline-info"
source /usr/share/fzf/key-bindings.zsh

# Rust
source $HOME/.cargo/env
