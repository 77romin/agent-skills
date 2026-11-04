#!/usr/bin/env bash
set -euo pipefail

if ! command -v tmux >/dev/null 2>&1; then
  printf 'tmux is not installed. macOS: brew install tmux\n' >&2
  exit 1
fi

PROJECT_DIR="${1:-.}"
if [[ ! -d "$PROJECT_DIR" ]]; then
  printf 'Project directory not found: %s\n' "$PROJECT_DIR" >&2
  exit 1
fi
PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd -P)"
SESSION="contest"

if ! tmux has-session -t "=$SESSION" 2>/dev/null; then
  tmux new-session -d -s "$SESSION" -n codex -c "$PROJECT_DIR"
  tmux new-window -d -t "$SESSION:" -n server -c "$PROJECT_DIR"
  tmux new-window -d -t "$SESSION:" -n test -c "$PROJECT_DIR"
  tmux select-window -t "$SESSION:codex"
  printf 'Created tmux session %s in %s\n' "$SESSION" "$PROJECT_DIR"
else
  printf 'Reusing existing tmux session %s (no existing windows were modified).\n' "$SESSION"
fi

printf 'Windows: codex (run codex manually), server (start dev server), test (run tests).\n'
if [[ -n "${TMUX:-}" ]]; then
  tmux switch-client -t "$SESSION"
else
  tmux attach-session -t "$SESSION"
fi
