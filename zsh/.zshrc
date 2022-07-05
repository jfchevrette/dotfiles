# ~/.zshrc
#
#
# shellcheck disable=SC1090,SC2148

[[ ! -d $HOME/.zgenom ]] && git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
export ZGEN_RESET_ON_CHANGE=("${HOME}/.zshrc" "${HOME}/.zshenv")
source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate

if ! zgenom saved; then
  zgenom load zdharma/fast-syntax-highlighting
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-completions
  zgenom load jfchevrette/zsh-titles
  zgenom save
  zgenom compile "$HOME/.zshrc"
fi

export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

myhistory() { fc -Drlim "*$@*" 1 }
alias history=myhistory
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

# git aliases
alias gap="git add -p";
alias gc="git commit";
alias gca="git commit -a";
alias gd="git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat";
alias gl="git log --oneline --color=always | fzf --ansi --preview=\"echo {} | cut -d ' ' -f 1 | xargs -I @ sh -c 'git log --pretty=medium -n 1 @; git diff @^ @' | bat --color=always\" | cut -d ' ' -f 1 | xargs git log --pretty=short -n 1";
alias gp="git pull";
alias gs="git status -sb";

# exa
if hash exa 2> /dev/null; then alias ls='exa -alghH --git'; fi
alias ll=ls -alsnew

# prefer GNU utilisies sed b/c BSD ones are weird
for util in grep sed; do
    if hash g$util 2> /dev/null; then alias $util=g$util; fi
done

if hash kubectl 2> /dev/null; then
  alias k=kubectl
  alias kc=kubectx
fi

if hash oc 2> /dev/null; then
  alias o="oc"
  alias og="oc get --show-kind=true"
  alias ol="oc logs"
  alias od="oc describe"
  alias or="oc rsh -it"
fi

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
alias daily='cat ~/work/daily/daily-$(date "+%Y%m%d").txt'
alias vidaily='vim ~/work/daily/daily-$(date "+%Y%m%d").txt'
alias todo='cat ~/work/todo.txt'

# Bitwarden
function bwunlock() {
  export BW_SESSION=$(bw unlock --raw)
}

# FZF
export FZF_DEFAULT_COMMAND="rg --one-file-system --files"
export FZF_DEFAULT_OPTS="--ansi --inline-info"
test -f /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/key-bindings.zsh
test -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Neovim
if hash nvim 2> /dev/null; then alias vim=nvim; fi

# Direnv
if hash direnv 2> /dev/null; then eval "$(direnv hook zsh)"; fi

# Starship prompt
if hash starship 2> /dev/null; then eval "$(starship init zsh)"; fi

#  Zoxide
if hash zoxide 2> /dev/null; then eval "$(zoxide init zsh)"; fi

# Bat
if hash bat 2> /dev/null; then alias cat=bat; fi

# Change dir with fuzzy finding
cf() {
  dir=$(fd . ''${1:-$HOME} --type d 2> /dev/null | fzf )
  cd "$dir"
}

# Search files and edit
fe() {
  rg --files ''${1:-.} | fzf --preview 'bat -f {}' | xargs nvim
}

# Search content and Edit
se() {
  fileline=$(rg -n ''${1:-.} | fzf | awk '{print $1}' | sed 's/.$//')
  nvim ''${fileline%%:*} +''${fileline##*:}
}

# asdf-vm
. /opt/homebrew/opt/asdf/libexec/asdf.sh
