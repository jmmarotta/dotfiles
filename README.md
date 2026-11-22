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

If `~/.config/mise/config.toml` or `~/.local/bin/luarocks` already exist as real
files on the machine, adopt them first:

```
stow --adopt mise luarocks
stow nvim zsh tmux
```

Then install a dedicated LuaRocks build against Homebrew LuaJIT:

```
install-luarocks-luajit
```

Verify:

```
luarocks --version
luarocks config lua_version
luarocks config variables.LUA
```

Expected:

```
3.x
5.1
/opt/homebrew/opt/luajit/bin/luajit
```

## Rex on macOS

Install [Rex Beta](https://www.superlogical.com/rex/docs/installation#macos), then run `stow rex` from this repo. Inside Rex, run `rex config check` and `rex config reload` after editing `init.lua`.

Stow installs the shortcuts, not the app preferences. In Rex Settings, set the terminal font to **JetBrainsMono Nerd Font Mono** at **14 pt**, set the cursor to **Bar**, enable **Copy on Selection**, and set **Option Key** to send Alt on the left only. Import `Everforest Light Soft` and `Everforest Dark Medium` from `ghostty/.config/ghostty/themes/`, assign them to Light Mode and Dark Mode respectively, and set **Color Scheme** to **Auto**.

`Ctrl+Space` is a one-shot prefix. Use `c` for a new tab, `%` or `"` to split, `Shift+T` for the three-pane layout, and `s` to save the current pane's scrollback to a temporary file and copy its path to the clipboard. `w` opens Go to Anything when **Settings → Developer → Experimental → New Quick Switcher** is enabled. Outside the prefix, `Cmd+U` and `Cmd+D` scroll one page up or down. Rex Beta 0.1.0 (build 1996) does not expose the vi-style copy-mode action, so `Ctrl+Space [` is not bound.

# TODO

need to add this:
brew install coreutils ed findutils gawk gnu-sed gnu-tar grep make

# Claude
https://github.com/docker/mcp-servers
