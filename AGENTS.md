# Repository guidelines

This repository contains personal, cross-platform dotfiles. Keep changes small,
portable, and safe to apply repeatedly.

## Layout

- Root files are shell and terminal configuration; `install.sh` links them into
  the home directory.
- `config/` mirrors application configuration under `~/.config`.
- `bin/` contains small user-facing utilities.
- `python/` defines the locked shared uv environment.
- `docs/` contains standalone setup notes.

## Change rules

- Preserve installer idempotency. Resolve paths from the repository location,
  leave correct symlinks untouched, and back up conflicts under `_backups/`.
- Do not run `install.sh` unless explicitly asked: it changes the user's home
  directory. macOS defaults must remain opt-in via `--macos-defaults`.
- Keep login profiles self-contained. The portable environment is intentionally
  duplicated between Bash and Zsh; interactive integrations belong in `bashrc`
  or `zshrc`. PATH updates must not accumulate duplicate entries.
- Never commit credentials, tokens, authentication state, caches, or host-only
  values. Put machine-specific paths and secrets in
  `~/.config/dotfiles/local.sh`.
- Keep personal agent configuration out of this repository. In particular, do
  not commit Codex configuration, trusted-project lists, or absolute home paths.
- Follow `.editorconfig`: LF endings, final newline, two-space indentation for
  shell/config files, and four spaces for Python.
- When Python dependencies change, update both `python/pyproject.toml` and
  `python/uv.lock` with uv. Keep the shared environment lightweight.
- Update `README.md` when installation behavior or user-facing conventions
  change.

## Validation

Run checks relevant to the edited files:

```bash
bash -n install.sh bash_profile bashrc
zsh -n zprofile zshrc
uv lock --check --project python
.githooks/pre-commit
git diff --check
```

For installer-wide or platform-sensitive changes, also build the Docker image:

```bash
docker build -t dotfiles .
```

Do not push or force-push unless the user explicitly requests it. Keep commits
focused on one configuration concern and use concise imperative messages.
