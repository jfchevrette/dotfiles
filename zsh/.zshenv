# PATH
export PATH="${PATH}:${HOME}/bin"

# Rust/Cargo
if [[ -f $HOME/.cargo/env ]]; then
    source "$HOME/.cargo/env"
fi

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# LunarVim
export PATH=/Users/jfchevrette/.local/bin:$PATH
