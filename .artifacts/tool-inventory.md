# Tool Inventory

Collected: 2026-06-07

## Summary

- Homebrew is installed at `/opt/homebrew`.
- Homebrew currently has 238 formulae, 79 casks, 9 taps, and 62 leaf formulae.
- `mise` is installed by Homebrew and manages the active language runtimes: Bun, Go, Node, Python, Ruby, and Zig.
- Neovim Mason manages 31 editor tooling packages under `~/.local/share/nvim/mason`.
- Rust/Cargo are standalone via `rustup` under `~/.rustup` and `~/.cargo/bin`.
- Other standalone/user-local tools exist under `~/.bun/bin`, `~/.local/bin`, `~/Library/pnpm/bin`, `/usr/local/bin`, `/opt/cloud66/bin`, and `~/.local/opt/luarocks-luajit/bin`.
- Legacy version-manager directories exist for `pyenv`, `rbenv`, and `nvm`, even though the active runtimes are coming from `mise`.

## Target Ownership Policy

- `mise` owns version-sensitive tools: language runtimes, compilers, IaC/Kubernetes CLIs, linters, formatters, and language servers that may need per-project versions.
- Homebrew owns one-global-version tools: native libraries, services, casks, macOS integrations, and general-purpose CLIs where project versioning is not important.
- Mason is a Neovim fallback installer, not the primary owner. Terminal Neovim should use the same tools as the shell via `PATH`; Mason binaries are used only when a shell tool is missing.

### Cleanup Applied

The following Homebrew formulae were uninstalled after their ownership moved to `mise`:

- `terraform`
- `helm`
- `lua-language-server`
- `tflint`
- `golangci-lint`
- `ruff`
- `rust-analyzer`
- `go`, auto-removed by Homebrew as an unneeded dependency

Post-cleanup verification showed interactive zsh resolving these tools from `mise` where applicable.

## Homebrew

### Taps

- `airbrake/airbrake-cli`
- `ariga/tap`
- `cameroncooke/axe`
- `hashicorp/tap`
- `heroku/brew`
- `homebrew/bundle`
- `homebrew/services`
- `mattt/tap`
- `oven-sh/bun`

### Explicit Formulae

These are `brew leaves`, which is the best approximation of intentionally installed formulae rather than dependencies.

- `act`
- `aichat`
- `airbrake/airbrake-cli/airbrake`
- `argparse`
- `ariga/tap/atlas`
- `awscli`
- `bat`
- `cameroncooke/axe/axe`
- `cmake`
- `coreutils`
- `ed`
- `fd`
- `ffmpeg`
- `findutils`
- `fzf`
- `gawk`
- `gh`
- `ghostscript`
- `git`
- `git-delta`
- `gnu-sed`
- `gnu-tar`
- `gobject-introspection`
- `golangci-lint`
- `graphviz`
- `grep`
- `guile`
- `hashicorp/tap/terraform`
- `helm`
- `heroku/brew/heroku`
- `heroku/brew/heroku-node`
- `iproute2mac`
- `jq`
- `lazygit`
- `lefthook`
- `lua-language-server`
- `make`
- `mas`
- `mise`
- `neovim`
- `ollama`
- `openjdk@17`
- `openssl@1.1`
- `overmind`
- `pdm`
- `pipx`
- `pnpm`
- `postgresql@14`
- `protobuf`
- `python@3.11`
- `python@3.9`
- `redis`
- `rlwrap`
- `ruby-build`
- `ruff`
- `rust-analyzer`
- `stow`
- `tflint`
- `tree`
- `uv`
- `vips`
- `zoxide`

### Casks

- `bruno`
- `chromium`
- `codex`
- `font-0xproto-nerd-font`
- `font-3270-nerd-font`
- `font-agave-nerd-font`
- `font-anonymice-nerd-font`
- `font-arimo-nerd-font`
- `font-aurulent-sans-mono-nerd-font`
- `font-bigblue-terminal-nerd-font`
- `font-bitstream-vera-sans-mono-nerd-font`
- `font-blex-mono-nerd-font`
- `font-caskaydia-cove-nerd-font`
- `font-caskaydia-mono-nerd-font`
- `font-code-new-roman-nerd-font`
- `font-comic-shanns-mono-nerd-font`
- `font-commit-mono-nerd-font`
- `font-cousine-nerd-font`
- `font-d2coding-nerd-font`
- `font-daddy-time-mono-nerd-font`
- `font-dejavu-sans-mono-nerd-font`
- `font-droid-sans-mono-nerd-font`
- `font-envy-code-r-nerd-font`
- `font-fantasque-sans-mono-nerd-font`
- `font-fira-code-nerd-font`
- `font-fira-mono-nerd-font`
- `font-geist-mono-nerd-font`
- `font-go-mono-nerd-font`
- `font-gohufont-nerd-font`
- `font-hack-nerd-font`
- `font-hasklug-nerd-font`
- `font-heavy-data-nerd-font`
- `font-hurmit-nerd-font`
- `font-im-writing-nerd-font`
- `font-inconsolata-go-nerd-font`
- `font-inconsolata-lgc-nerd-font`
- `font-inconsolata-nerd-font`
- `font-intone-mono-nerd-font`
- `font-iosevka-nerd-font`
- `font-iosevka-term-nerd-font`
- `font-iosevka-term-slab-nerd-font`
- `font-jetbrains-mono-nerd-font`
- `font-lekton-nerd-font`
- `font-liberation-nerd-font`
- `font-lilex-nerd-font`
- `font-m+-nerd-font`
- `font-martian-mono-nerd-font`
- `font-meslo-lg-nerd-font`
- `font-monaspace-nerd-font`
- `font-monaspice-nerd-font`
- `font-monocraft-nerd-font`
- `font-monofur-nerd-font`
- `font-monoid-nerd-font`
- `font-mononoki-nerd-font`
- `font-noto-nerd-font`
- `font-open-dyslexic-nerd-font`
- `font-opendyslexic-nerd-font`
- `font-overpass-nerd-font`
- `font-profont-nerd-font`
- `font-proggy-clean-tt-nerd-font`
- `font-recursive-mono-nerd-font`
- `font-roboto-mono-nerd-font`
- `font-sauce-code-pro-nerd-font`
- `font-shure-tech-mono-nerd-font`
- `font-space-mono-nerd-font`
- `font-symbols-only-nerd-font`
- `font-terminess-ttf-nerd-font`
- `font-tinos-nerd-font`
- `font-ubuntu-mono-nerd-font`
- `font-ubuntu-nerd-font`
- `font-ubuntu-sans-nerd-font`
- `font-victor-mono-nerd-font`
- `font-zed-mono-nerd-font`
- `gcloud-cli`
- `ghostty`
- `google-cloud-sdk`
- `imcp`
- `mitmproxy`
- `xquartz`

### Services

- `postgresql@14`: started for `julianmarotta`
- `redis`: started for `julianmarotta`
- `ollama`: not running through Homebrew services
- `unbound`: not running through Homebrew services

### Mac App Store

`mas list` reported no installed apps.

## mise

`mise` itself is installed by Homebrew at `/opt/homebrew/bin/mise`.

Version: `2026.1.6 macos-arm64`; `mise doctor` reports a newer `2026.6.1` is available, but no problems.

### Active Global Tools

Configured in `~/.config/mise/config.toml`, which matches `mise/.config/mise/config.toml` in this dotfiles repo.

- `bun = "1"` -> active `1.3.9`
- `go = "1"` -> active `1.26.1`
- `node = "26"` -> active `26.1.0`
- `python = "3"` -> active `3.14.3`
- `ruby = "3.3"` -> active `3.3.8`
- `zig = "0.15.2"` -> active `0.15.2`
- `rust = "stable"`
- `terraform = "latest"`
- `tflint = "latest"`
- `helm = "latest"`
- `golangci-lint = "latest"`
- `ruff = "latest"`
- `stylua = "latest"`
- `lua-language-server = "latest"`
- `actionlint = "latest"`
- `terraform-ls = "latest"`
- `zls = "latest"`
- `rust-analyzer = "latest"`
- `go:golang.org/x/tools/gopls = "latest"`

### Installed mise Versions

- Bun: `1.3.9`
- Go: `1.23.2`, `1.25.7`, `1.25.8`, `1.26.1`
- Node: `22.14.0`, `24.13.1`, `25.4.0`, `26.1.0`
- Python: `3.14.3`
- Ruby: `jruby-9.3.9.0`, `2.7.2`, `3.3.5`, `3.3.8`, `4.0.1`
- Zig: `master`, `0.15.2`

### mise PATH Entries

- `~/.local/share/mise/installs/ruby/3.3.8/bin`
- `~/.local/share/mise/installs/python/3.14.3/bin`
- `~/.local/share/mise/installs/node/26.1.0/bin`
- `~/.local/share/mise/installs/bun/1.3.9/bin`
- `~/.local/share/mise/installs/go/1.26.1/bin`
- `~/.local/share/mise/installs/zig/0.15.2/bin`

`mise doctor` says `shims_on_path: no`; this shell is using direct install paths rather than `mise` shims.

## Neovim Mason

Mason installs are under `~/.local/share/nvim/mason`.

The active Neovim config uses `mason-org/mason.nvim` and `WhoIsSethDaniel/mason-tool-installer.nvim` in `nvim/.config/nvim/lua/plugins/lsp.lua`. Mason is configured with `PATH = "skip"`, so it does not shadow shell tools. LSP commands resolve the executable from Neovim's inherited terminal `PATH` first, then fall back to `~/.local/share/nvim/mason/bin`.

The config still builds its Mason `ensure_installed` list from declared LSP servers plus additional formatter/linter tools so Mason can provide fallback installs.

### Configured LSP Servers

- `clangd`
- `dockerfile-language-server` -> binary `docker-langserver`
- `gh-actions-language-server` -> binary `gh-actions-language-server`
- `gopls`
- `json-lsp` -> binary `vscode-json-language-server`
- `lua-language-server`
- `pyright` -> binary `pyright-langserver`
- `rust-analyzer`
- `standardrb`
- `terraform-ls`
- `vtsls`
- `yaml-language-server`
- `zls`

### Configured Additional Tools

- `actionlint`
- `eslint_d`
- `golangci-lint`
- `luacheck`
- `oxfmt`
- `oxlint`
- `prettier`
- `ruff`
- `stylua`
- `tflint`
- `yamllint`

### Installed Mason Packages

Observed package directories in `~/.local/share/nvim/mason/packages`:

- `actionlint`
- `biome`
- `clangd`
- `delve`
- `dockerfile-language-server`
- `eslint_d`
- `eslint-lsp`
- `gh-actions-language-server`
- `golangci-lint`
- `gopls`
- `html-lsp`
- `json-lsp`
- `lua-language-server`
- `luacheck`
- `markdownlint`
- `oxfmt`
- `oxlint`
- `prettier`
- `prettierd`
- `pyright`
- `rubocop`
- `ruff`
- `rust-analyzer`
- `standardrb`
- `stylua`
- `terraform-ls`
- `tflint`
- `vtsls`
- `yaml-language-server`
- `yamllint`
- `zls`

### Mason Binaries

Observed binaries in `~/.local/share/nvim/mason/bin`:

- `actionlint`
- `actions-languageserver`
- `biome`
- `clangd`
- `dlv`
- `docker-langserver`
- `eslint_d`
- `gh-actions-language-server`
- `golangci-lint`
- `gopls`
- `lua-language-server`
- `luacheck`
- `markdownlint`
- `oxfmt`
- `oxlint`
- `prettier`
- `prettierd`
- `pyright`
- `pyright-langserver`
- `rubocop`
- `ruff`
- `rust-analyzer`
- `standardrb`
- `stylua`
- `terraform-ls`
- `tflint`
- `vscode-eslint-language-server`
- `vscode-html-language-server`
- `vscode-json-language-server`
- `vtsls`
- `yaml-language-server`
- `yamllint`
- `zls`

### Mason Extras Not Currently Ensured

These are installed in Mason but do not appear in the current `ensure_installed` list from `nvim/.config/nvim/lua/plugins/lsp.lua`:

- `biome`
- `delve`
- `eslint-lsp`
- `html-lsp`
- `markdownlint`
- `prettierd`
- `rubocop`

Those may be intentional manual installs, historical leftovers, or tools referenced elsewhere in the Neovim config.

## Standalone / User-Local Installs

### Rust / Cargo

Rust is standalone via `rustup`.

- `rustup home`: `~/.rustup`
- active toolchain: `stable-aarch64-apple-darwin`, default
- installed target: `aarch64-apple-darwin`
- `rustc`: `1.96.0 (ac68faa20 2026-05-25)` at `~/.cargo/bin/rustc`
- `cargo`: `1.96.0 (30a34c682 2026-05-25)` at `~/.cargo/bin/cargo`
- `rustup`: `~/.cargo/bin/rustup`
- `cargo install --list`: no installed cargo packages reported

Executables in `~/.cargo/bin`:

- `cargo`
- `cargo-clippy`
- `cargo-fmt`
- `cargo-miri`
- `clippy-driver`
- `rls`
- `rust-analyzer`
- `rust-gdb`
- `rust-gdbgui`
- `rust-lldb`
- `rustc`
- `rustdoc`
- `rustfmt`
- `rustup`

Note: Homebrew also has `rust-analyzer` installed, but `~/.cargo/bin` is earlier on `PATH`.

### Bun Global Packages

Global Bun packages live under `~/.bun/bin` and `~/.bun/install/global`.

- `@anthropic-ai/claude-code@1.0.31` -> `claude`
- `@dhruvwill/skills-cli@1.1.2`
- `expo-cli@6.3.10` -> `expo`, `expo-cli`
- `hunkdiff@0.12.0` -> `hunk`, `hunkdiff`
- `mcporter@0.7.3` -> `mcporter`
- `opencode-ai@1.16.2` -> `opencode`
- `playwriter@0.0.80` -> `playwriter`
- `sst@3.13.17` -> `sst`
- `turbo@2.6.0` -> `turbo`
- additional binary observed: `aglit`, `seal`

### pnpm Global Packages

Global pnpm packages live under `~/Library/pnpm/global/v11`, with binaries in `~/Library/pnpm/bin`.

- `@earendil-works/pi-coding-agent@0.78.0` -> `pi`
- `@pnpm/exe@11.1.2` -> `pn`, `pnpx`, `pnx`

### npm Global Packages

The active `npm` is from mise Node at `~/.local/share/mise/installs/node/26.1.0/bin/npm`.

Global packages reported under the mise Node prefix:

- `npm@11.13.0`
- `pnpm@11.1.2`

### Python User Tools

`pipx` is installed by Homebrew, but it manages user-local venvs and exposes apps in `~/.local/bin`.

- `poetry 1.8.3`, installed using Python `3.12.3`, exposes `poetry`

`uv tool list` reported:

- broken/missing interpreter for `aider-chat`: `~/.local/share/uv/tools/aider-chat/bin/python3` not found
- `llm-tldr v1.5.2`, exposing `llm-tldr`, `tldr`, `tldr-mcp`

Additional executables observed in `~/.local/bin`:

- `aider`
- `install-luarocks-luajit`
- `llm-tldr`
- `luarocks`
- `pdm`
- `poetry`
- `tldr`
- `tldr-mcp`

### LuaRocks / LuaJIT

Standalone/user-local LuaRocks path: `~/.local/opt/luarocks-luajit/bin`.

- `luacheck`
- `luarocks`
- `luarocks-admin`

The mise config explicitly says LuaJIT is installed with Homebrew for Neovim/LuaRocks compatibility, and the `mise` LuaJIT entry is commented out.

### `/usr/local/bin`

These are not under the Homebrew prefix on Apple Silicon. They appear to be app-managed standalone installs, mostly Docker Desktop, VS Code/Cursor, VirtualBox, and an older/non-mise Node.

- `code`
- `com.docker.cli`
- `corepack`
- `cursor`
- `docker`
- `docker-compose`
- `docker-compose-v1`
- `docker-credential-desktop`
- `docker-credential-ecr-login`
- `docker-credential-osxkeychain`
- `docker-index`
- `hub-tool`
- `kubectl`
- `kubectl.docker`
- `node`
- `npm`
- `npx`
- `vboximg-mount`
- `vpnkit`

### Other Standalone Paths

- `~/bin`: `cht.sh`
- `/opt/cloud66/bin`: `cx`
- `/opt/sst`: present
- `~/.opencode/bin`: present but empty
- `/opt/X11` and `/usr/X11/bin`: likely from Homebrew cask `xquartz`
- `/opt/homebrew/share/google-cloud-sdk/bin`: from Homebrew cask `google-cloud-sdk` / `gcloud-cli`

## Legacy Version Managers Present

These directories exist and may contain old installs, but active `which -a` checks show `mise` versions winning for Node, Python, and Ruby.

### pyenv

Installed versions:

- `3.10.11`
- `3.10.12`
- `3.11.4`
- `3.12.2`

### rbenv

Installed versions:

- `2.7.2`
- `3.1.1`
- `3.2.2`

### nvm

Installed Node versions:

- `v16.16.0`
- `v20.12.1`
- `v20.14.0`
- `v20.17.0`
- `v20.5.1`
- `v20.9.0`

## Duplicate / Cleanup Candidates

- Node/npm exist in `mise`, `/usr/local/bin`, and Homebrew (`/opt/homebrew/bin/npm`). Active versions are from `mise` because `mise` install paths are first on `PATH`.
- `pnpm` exists in `mise` Node, Homebrew, and `~/Library/pnpm/bin`.
- Go is owned by `mise`. The previous Homebrew `go` install was auto-removed after Brew duplicates were uninstalled.
- Python exists in `mise`, Homebrew, system Python, and old `pyenv` installs. Active `python`/`python3` are from `mise`.
- Ruby exists in `mise`, system Ruby, and old `rbenv` installs. Active Ruby is from `mise`.
- `rust-analyzer` exists in Rustup/Cargo and `mise`; interactive zsh and terminal Neovim resolve the `mise` version.
- `rust-analyzer`, `golangci-lint`, `lua-language-server`, `ruff`, `terraform-ls`, `tflint`, and other editor tools are also installed by Mason for Neovim. Neovim config points directly at Mason binaries, while the shell usually resolves to `mise`, Homebrew, or Rustup versions.
- Mason has installed packages that are not currently in the Neovim `ensure_installed` list: `biome`, `delve`, `eslint-lsp`, `html-lsp`, `markdownlint`, `prettierd`, and `rubocop`.
- `aider-chat` appears broken under `uv tool list` because its interpreter path is missing.
- `pyenv`, `rbenv`, and `nvm` contain older versions that may be removable if you are standardizing on `mise`.

## Verification Commands Run

- `brew --prefix`
- `brew list --formula`
- `brew list --cask`
- `brew tap`
- `brew services list`
- `brew leaves`
- `brew bundle dump --file=- --describe`
- `mas list`
- `mise ls`
- `mise ls --global`
- `mise settings`
- `mise doctor`
- `rustup show`
- `rustc --version`
- `cargo --version`
- `which -a rustc cargo rustup node npm pnpm bun go python python3 ruby gem zig opencode codex gh git`
- `cargo install --list`
- `bun pm ls -g`
- `npm ls -g --depth=0`
- `pnpm list -g --depth=0`
- `pipx list`
- `uv tool list`
- read `~/.local/share/nvim/mason/packages`
- read `~/.local/share/nvim/mason/bin`
- inspected `nvim/.config/nvim/lua/plugins/lsp.lua` for Mason configuration
