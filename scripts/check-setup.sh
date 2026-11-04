#!/usr/bin/env bash
set -euo pipefail

CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
SKILLS_DIR="${AGENTS_SKILLS_HOME:-$HOME/.agents/skills}"
failed=0

check_file() {
  local target="$1"
  if [[ -f "$target" ]]; then
    printf 'PASS %s\n' "$target"
  else
    printf 'FAIL %s\n' "$target"
    failed=1
  fi
}

for agent in planner generator reviewer qa; do
  check_file "$CODEX_DIR/agents/$agent.toml"
done
check_file "$SKILLS_DIR/contest-webapp/SKILL.md"
check_file "$SKILLS_DIR/contest-webapp/references/edge-case-checklist.md"

if command -v codex >/dev/null 2>&1; then
  printf 'PASS codex executable: %s\n' "$(command -v codex)"
else
  printf 'WARN Codex CLI executable not found in PATH (install or use compatible Codex app).\n'
fi

printf '\nNote: file presence alone does not prove your Codex version supports custom agents.\n'
printf 'Restart Codex and check agent discovery / $contest-webapp in a test project.\n'

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi
