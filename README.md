# Brewfile how-to
https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f

## Dumping the brewfile

```
brew bundle dump
```

## Installing the brewfile (from ~/Brewfile)

```
brew bundle install
```

# GNU stow commands
https://gist.github.com/andreibosco/cb8506780d0942a712fc

```
stow nvim zsh tmux mise luarocks
```

If `~/.config/mise/config.toml` or `~/.luarocks/config.lua` already exist as real
files on the machine, adopt them first:

```
stow --adopt mise luarocks
stow nvim zsh tmux
```

Then verify LuaRocks is targeting Neovim's LuaJIT-compatible runtime:

```
luarocks config lua_version
luarocks config variables.LUA
```

Expected:

```
5.1
/opt/homebrew/opt/luajit/bin/luajit
```

# TODO

need to add this:
brew install coreutils ed findutils gawk gnu-sed gnu-tar grep make

# Claude
https://github.com/docker/mcp-servers
