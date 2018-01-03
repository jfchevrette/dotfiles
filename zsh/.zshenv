if [[ -d "$HOME/.zshenv.d" ]]; then
  for EXTFILE in $(find "$HOME/.zshenv.d/ -name '*.zsh'"); do
    source "$EXTFILE"
  done
fi
