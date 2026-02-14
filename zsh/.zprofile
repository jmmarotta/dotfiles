# Login shell environment.

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

export PNPM_HOME="$HOME/Library/pnpm"

typeset -U path PATH
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "/usr/local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.bun/bin"
  "$PNPM_HOME"
  "/opt/cloud66/bin"
  "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
  "/opt/homebrew/opt/ed/libexec/gnubin"
  "/opt/homebrew/opt/gawk/libexec/gnubin"
  "/opt/homebrew/opt/grep/libexec/gnubin"
  "/opt/homebrew/opt/make/libexec/gnubin"
  "/opt/homebrew/opt/gnu-tar/libexec/gnubin"
  "/opt/homebrew/opt/openjdk@17/bin"
  "/usr/X11/bin"
  "$HOME/.opencode/bin"
  $path
)
export PATH

export DISPLAY=:0
export EDITOR="nvim"
export AWS_PROFILE="$AWS_DEFAULT_PROFILE"
export NODE_OPTIONS="--disable-warning=ExperimentalWarning"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export OPENCODE_EXPERIMENTAL_MARKDOWN=true

if command -v brew >/dev/null 2>&1; then
  gcloud_path_script="$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  if [ -f "$gcloud_path_script" ]; then
    source "$gcloud_path_script"
  fi
fi

if [ -f "$HOME/.zshsecrets" ]; then
  . "$HOME/.zshsecrets"
fi
