#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
SKILLS_DIR="${AGENTS_SKILLS_HOME:-$HOME/.agents/skills}"
BACKUP_TAG="$(date +%Y%m%d-%H%M%S)-$$"

install_one() {
  local src="$1" dst="$2"
  if [[ ! -f "$src" ]]; then
    printf 'ERROR: source not found: %s\n' "$src" >&2
    return 1
  fi

  mkdir -p "$(dirname "$dst")"

  # Never follow or replace a user-managed symlink.
  if [[ -L "$dst" ]]; then
    printf 'SKIP (symlink, manual review needed): %s\n' "$dst"
    return 0
  fi

  if [[ -f "$dst" ]]; then
    if cmp -s "$src" "$dst"; then
      printf 'OK (unchanged): %s\n' "$dst"
      return 0
    fi
    cp -p "$dst" "${dst}.backup.${BACKUP_TAG}"
    printf 'BACKUP: %s.backup.%s\n' "$dst" "$BACKUP_TAG"
  elif [[ -e "$dst" ]]; then
    printf 'SKIP (not a regular file): %s\n' "$dst"
    return 0
  fi

  cp -p "$src" "$dst"
  printf 'INSTALLED: %s\n' "$dst"
}

printf 'Installing Codex contest agents from %s\n' "$REPO_ROOT"

for agent in planner generator reviewer qa; do
  install_one "$REPO_ROOT/agents/$agent.toml" "$CODEX_DIR/agents/$agent.toml"
done

install_one "$REPO_ROOT/.agents/skills/contest-webapp/SKILL.md" "$SKILLS_DIR/contest-webapp/SKILL.md"
install_one "$REPO_ROOT/.agents/skills/contest-webapp/references/edge-case-checklist.md" "$SKILLS_DIR/contest-webapp/references/edge-case-checklist.md"

printf '\nInstall complete. No config.toml or AGENTS.md was changed.\n'
printf 'Restart Codex, open your CONTEST project folder, and paste prompts/START_CONTEST.md.\n'
printf 'Run bash scripts/check-setup.sh to verify installation.\n'
