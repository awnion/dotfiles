# vim: ft=zsh

[[ -n "${__ZPROFILE:-}" ]] && return 0
__ZPROFILE=1

_dotfiles_path_remove () {
  local value=":${PATH:-}:"
  value="${value//":$1:"/:}"
  PATH="${value#:}"
  PATH="${PATH%:}"
}

_dotfiles_path_prepend () {
  [[ -d "$1" ]] || return 0
  _dotfiles_path_remove "$1"
  PATH="$1${PATH:+:$PATH}"
}

_dotfiles_path_append () {
  [[ -d "$1" ]] || return 0
  _dotfiles_path_remove "$1"
  PATH="${PATH:+$PATH:}$1"
}

# Local system tools.
_dotfiles_path_prepend /usr/local/sbin
_dotfiles_path_prepend /usr/local/bin

# Homebrew/Linuxbrew takes precedence over /usr/local and system tools.
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  _dotfiles_path_prepend "$HOMEBREW_PREFIX/sbin"
  _dotfiles_path_prepend "$HOMEBREW_PREFIX/bin"
fi

# Language toolchains.
_dotfiles_path_prepend "$HOME/.cargo/bin"

export ZVM_INSTALL="$HOME/.zvm/self"
_dotfiles_path_prepend "$ZVM_INSTALL"
_dotfiles_path_prepend "$HOME/.zvm/bin"

_dotfiles_path_prepend "$HOME/go/bin"

export BUN_INSTALL="$HOME/.bun"
_dotfiles_path_prepend "$BUN_INSTALL/bin"

_dotfiles_path_prepend "$HOME/.deno/bin"

export WASMTIME_HOME="$HOME/.wasmtime"
_dotfiles_path_prepend "$WASMTIME_HOME/bin"

# Homebrew-provided tools that are intentionally exposed by their default names.
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  _dotfiles_path_prepend "$HOMEBREW_PREFIX/opt/ruby/bin"
  _dotfiles_path_prepend "$HOMEBREW_PREFIX/opt/llvm/bin"
  _dotfiles_path_prepend "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
  _dotfiles_path_prepend "$HOMEBREW_PREFIX/opt/uutils-coreutils/libexec/uubin"
fi

# Platform-specific developer tools.
_dotfiles_path_append "$HOME/.gosh"

if [[ -d "$HOME/Library/Android/sdk" ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
fi
_dotfiles_path_append "$HOME/Library/Android/sdk/emulator"
_dotfiles_path_append "$HOME/Library/Android/sdk/platform-tools"

if [[ "${OSTYPE:-}" == darwin* ]]; then
  _dotfiles_path_prepend /Applications/RustRover.app/Contents/MacOS

  if [[ -n "${HOMEBREW_PREFIX:-}" ]] &&
     [[ -d "$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig" ]]; then
    case ":${PKG_CONFIG_PATH:-}:" in
      *":$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig:"*) ;;
      *) export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/readline/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}" ;;
    esac
  fi

  if command -v xcrun >/dev/null 2>&1; then
    _dotfiles_sdkroot="$(xcrun --sdk macosx --show-sdk-path 2>/dev/null || true)"
    [[ -n "$_dotfiles_sdkroot" ]] && export SDKROOT="$_dotfiles_sdkroot"
    unset _dotfiles_sdkroot
  fi
fi

# User commands and uv-managed tools override system executables.
_dotfiles_path_prepend "$HOME/.local/bin"
_dotfiles_path_prepend "$HOME/bin"
export PATH

export LANGUAGE=en_US.UTF-8

# Portable virtual-environment helpers.
venv () {
  local candidate

  if [[ -n "${VIRTUAL_ENV:-}" ]]; then
    printf 'virtualenv already active: %s\n' "$VIRTUAL_ENV"
    return 0
  fi

  for candidate in .venv/bin/activate venv/bin/activate; do
    if [[ -f "$candidate" ]]; then
      source "$candidate"
      printf 'activated %s\n' "$candidate"
      return 0
    fi
  done

  printf 'no .venv or venv found in %s\n' "$PWD" >&2
  return 1
}

createvenv () {
  local project_name="${PWD##*/}"
  [[ -n "$project_name" ]] || project_name=/

  if ! command -v uv >/dev/null 2>&1; then
    printf 'createvenv: uv is not installed or not on PATH\n' >&2
    return 127
  fi

  command uv venv --python 3.14.6 --prompt "$project_name" "$@" .venv
}

cvenv () {
  createvenv "$@"
}

# Optionally routes each session through the local proxy.
if [[ -e "$HOME/.claude/claude-code-proxy-enabled" ]]; then
  export ANTHROPIC_BASE_URL=http://127.0.0.1:8317
  export ANTHROPIC_AUTH_TOKEN=sk-123
  export ANTHROPIC_MODEL=gpt-5.6-sol
  export ANTHROPIC_SMALL_FAST_MODEL=gpt-5.6-luna
  export CLAUDE_CODE_SUBAGENT_MODEL=gpt-5.6-sol
  export CLAUDE_CODE_AUTO_COMPACT_WINDOW=270000
fi

# Machine-specific paths and secrets belong here, outside the repository.
_dotfiles_local_profile="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/local.sh"
[[ -r "$_dotfiles_local_profile" ]] && source "$_dotfiles_local_profile"
unset _dotfiles_local_profile
