# dotfiles

[![Docker Image](https://github.com/awnion/dotfiles/actions/workflows/docker.yml/badge.svg)](https://github.com/awnion/dotfiles/actions/workflows/docker.yml)

## Install

The installer resolves the repository from its own path, so it can be run from any directory:

```bash
bash /path/to/dotfiles/install.sh
```

Existing files that conflict with managed links are moved under
`_backups/<timestamp>/` inside the repository. The ignored backup directory is
kept out of Git. Re-running the installer leaves correct links unchanged.

macOS keyboard defaults are intentionally separate from link installation:

```bash
bash /path/to/dotfiles/install.sh --macos-defaults
```

## Shell startup

Each shell keeps its complete environment setup in its own login profile. The
portable PATH and helper declarations are intentionally duplicated so either
profile can be understood on its own. Interactive integrations remain
shell-specific:

- Zsh: `.zprofile` and `.zshrc`
- Bash: `.bash_profile` and `.bashrc`
- POSIX sh: `.profile`

Machine-specific paths and secrets can be placed in the untracked file:

```text
~/.config/dotfiles/local.sh
```

PATH changes are idempotent, so nested shells do not multiply entries.

## Neovim

The config in `config/nvim` targets the latest stable Neovim and needs `git`, a C
compiler, `tree-sitter-cli`, `node`, and `go` on `PATH`. The first start installs
plugins from `lazy-lock.json`, then treesitter parsers and language servers in
the background:

| Language | Tools |
| --- | --- |
| Python | `ty`, `ruff` (format on save) |
| TypeScript, JavaScript | `tsc` (TypeScript 7) |
| Lua | `emmylua_ls` |
| Rust | `rust-analyzer` through `rustaceanvim` |
| Go | `gopls` |
| Bash | `bash-language-server`, `shellcheck` |
| Docker | `docker-language-server` |

Check the config with `tests/nvim-smoke.sh`; the Docker build runs it too.

## Try it

```bash
docker run --rm -it ghcr.io/awnion/dotfiles
```

## Local build

```bash
docker build -t dotfiles .
docker run --rm -it dotfiles
```

## Commit checks

Enable the tracked pre-commit hook once per clone:

```bash
git config core.hooksPath .githooks
```

The hook runs Gitleaks against staged changes. `.gitleaks.toml` enables the
standard rules, while `.gitleaks-privacy.toml` rejects personal email addresses,
absolute macOS home paths, and Codex trusted-project entries.
