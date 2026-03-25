# Interactive shell configuration.

# Repo-managed completions must be in fpath before compinit (run by Oh My Zsh).
if [ -d "$HOME/.zfunc" ]; then
  fpath=("$HOME/.zfunc" $fpath)
fi

# Docker completions must be in fpath before compinit (run by Oh My Zsh).
if [ -d "$HOME/.docker/completions" ]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode rails)
source "$ZSH/oh-my-zsh.sh"

bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins '^N' down-line-or-beginning-search

alias zshc="nvim ~/.zshrc"
alias ohmyzshc="nvim ~/.oh-my-zsh"

alias nv="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvc="nvim ~/.config/nvim/init.lua"

alias oc="opencode --port"
alias occ="opencode --port --continue"
alias plan="openplan"
alias jj="git"
alias tf="terraform"
alias aic="aichat"

compdef _openplan plan
compdef _opencode oc occ

tmuxe() {
  if [ "$#" -eq 0 ]; then
    printf 'usage: tmuxe <command>\n' >&2
    return 1
  fi

  local cmd="$*"
  local panes

  panes=$(tmux list-panes -a -F '#{pane_id}' 2>/dev/null) || {
    printf 'tmuxe: no tmux server running\n' >&2
    return 1
  }

  while IFS= read -r pane; do
    [ -n "$pane" ] || continue
    tmux send-keys -t "$pane" "$cmd" C-m
  done <<< "$panes"
}

if command -v brew >/dev/null 2>&1; then
  gcloud_completion_script="$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  if [ -f "$gcloud_completion_script" ]; then
    source "$gcloud_completion_script"
  fi
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi
