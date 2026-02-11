# Interactive shell configuration.

# Docker completions must be in fpath before compinit (run by Oh My Zsh).
if [ -d "$HOME/.docker/completions" ]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode rails)
source "$ZSH/oh-my-zsh.sh"

alias zshc="nvim ~/.zshrc"
alias ohmyzshc="nvim ~/.oh-my-zsh"

# Effectively a tmux refresh: reload .zshrc in all tmux panes.
tmuxr() {
  tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' \
    | xargs -I{} tmux send-keys -t {} 'source ~/.zshrc' C-m
}

# Full tmux refresh: reload .zprofile and .zshrc in all tmux panes.
tmuxre() {
  tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' \
    | xargs -I{} tmux send-keys -t {} 'source ~/.zprofile && source ~/.zshrc' C-m
}

alias nv="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvc="nvim ~/.config/nvim/init.lua"

alias oc="opencode"
alias occ="opencode --continue"
alias jj="git"
alias tf="terraform"
alias aic="aichat"

tmux9() {
  tmux new-session -d -s ts
  for i in {1..9}; do
    tmux new-window -t ts
  done
  tmux attach-session -t ts
}

if command -v brew >/dev/null 2>&1; then
  gcloud_completion_script="$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  if [ -f "$gcloud_completion_script" ]; then
    source "$gcloud_completion_script"
  fi
fi

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

if command -v uv >/dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
fi

if command -v uvx >/dev/null 2>&1; then
  eval "$(uvx --generate-shell-completion zsh)"
fi

#compdef opencode
###-begin-opencode-completions-###
#
# yargs command completion script
#
# Installation: opencode completion >> ~/.zshrc
#    or opencode completion >> ~/.zprofile on OSX.
#
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi
###-end-opencode-completions-###
