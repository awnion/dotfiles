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

Machine-specific paths and secrets can be placed in the untracked file:

```text
~/.config/dotfiles/local.sh
```

PATH changes are idempotent, so nested shells do not multiply entries.

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
