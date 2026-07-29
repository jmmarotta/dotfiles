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
VI_MODE_SET_CURSOR=true
plugins=(git vi-mode rails)
source "$ZSH/oh-my-zsh.sh"

# Keep EOF available to foreground programs without letting it exit Zsh and
# close the terminal pane from an empty prompt.
setopt ignore_eof

bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins '^N' down-line-or-beginning-search

# Ghostty forwards its unconsumed scroll shortcuts so full-screen TUIs can use
# them. Ignore the legacy Alt sequences when ZLE owns the terminal instead.
_ignore_ghostty_scroll_key() { : }
zle -N _ignore_ghostty_scroll_key
bindkey -M viins $'\e\x02' _ignore_ghostty_scroll_key # Ctrl+Alt+B
bindkey -M vicmd $'\e\x02' _ignore_ghostty_scroll_key
bindkey -M viins $'\e\x06' _ignore_ghostty_scroll_key # Ctrl+Alt+F
bindkey -M vicmd $'\e\x06' _ignore_ghostty_scroll_key
bindkey -M viins $'\e\x15' _ignore_ghostty_scroll_key # Ctrl+Alt+U
bindkey -M vicmd $'\e\x15' _ignore_ghostty_scroll_key
bindkey -M viins $'\e\x04' _ignore_ghostty_scroll_key # Ctrl+Alt+D
bindkey -M vicmd $'\e\x04' _ignore_ghostty_scroll_key
bindkey -M viins $'\e\x07' _ignore_ghostty_scroll_key # Ctrl+Alt+G
bindkey -M vicmd $'\e\x07' _ignore_ghostty_scroll_key

alias zshc="nvim ~/.zshrc"
alias zshr="source ~/.zshrc"
alias ohmyzshc="nvim ~/.oh-my-zsh"

alias nv="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvc="nvim ~/.config/nvim/init.lua"

alias oc="opencode --port"
alias occ="opencode --port --continue"
alias bs="bonsai"
alias bsc="bonsai --continue"
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

# Select work-scoped CLI state while inside ~/hs-projects. The personal
# artifact store is the default everywhere else.
_gh_hs_config="$HOME/.config/gh-hs"
_hs_projects_root="$HOME/hs-projects"
_personal_artifacts_root="$HOME/projects/artifacts"
_hs_artifacts_root="$_hs_projects_root/artifacts"
_workspace_environment_chpwd() {
  case "$PWD/" in
    "$_hs_projects_root"/*)
      export GH_CONFIG_DIR="$_gh_hs_config"
      export ARTIFACTS_PATH="$_hs_artifacts_root"
      ;;
    *)
      unset GH_CONFIG_DIR
      export ARTIFACTS_PATH="$_personal_artifacts_root"
      ;;
  esac
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _workspace_environment_chpwd
_workspace_environment_chpwd  # apply for the shell's starting directory
