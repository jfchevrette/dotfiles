export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export MANPATH="/usr/local/man:$MANPATH"

# Go
export GOPATH=$HOME
export PATH="$GOPATH/bin:$PATH"

# Rust/cargo
export RUST_SRC_PATH=$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
export PATH=$HOME/.cargo/bin:$PATH
