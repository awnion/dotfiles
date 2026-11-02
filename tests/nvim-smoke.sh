#!/usr/bin/env bash
# Fails when the Neovim config reports an error while starting or opening a file.
set -uo pipefail

test_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

output="$(nvim --headless -i NONE -c "luafile $test_dir/nvim-smoke.lua" 2>&1)"
status=$?
printf '%s\n' "$output"

if (( status != 0 )); then
  printf 'nvim-smoke: nvim exited with status %s\n' "$status" >&2
  exit 1
fi

if grep -qE 'Failed to source|stack traceback|E[0-9]{3,4}:|deprecated|\berror:' <<<"$output"; then
  printf 'nvim-smoke: nvim reported errors or deprecations\n' >&2
  exit 1
fi
