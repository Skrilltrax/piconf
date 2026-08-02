#!/usr/bin/env bash
# piconf installer: symlinks settings + AGENTS.md, clones standard skill repos.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_DIR="${PI_DIR:-$HOME/.pi/agent}"
SKILLS_DIR="$PI_DIR/skills"

log() { printf '\033[1;34m[piconf]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[piconf]\033[0m %s\n' "$*" >&2; }
ok() { printf '\033[1;32m[piconf]\033[0m %s\n' "$*"; }

mkdir -p "$PI_DIR" "$SKILLS_DIR"

# --- 1. Back up and symlink config files ---
link_file() {
  local src="$1" dest="$2"
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
      return 0
    fi
    local backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    warn "Backed up existing $dest -> $backup"
  fi
  ln -s "$src" "$dest"
  ok "Linked $dest -> $src"
}

link_file "$REPO_DIR/settings.json" "$PI_DIR/settings.json"
link_file "$REPO_DIR/AGENTS.md"     "$PI_DIR/AGENTS.md"

# --- 2. Clone / update standard skill repos ---
# pi auto-discovers any folder with a SKILL.md under ~/.pi/agent/skills/,
# so cloned skills need no settings entries.
clone_or_update() {
  local url="$1" dest="$2"
  if [[ -d "$dest/.git" ]]; then
    log "Updating $(basename "$dest")..."
    git -C "$dest" pull --ff-only
  else
    log "Cloning $(basename "$dest")..."
    rm -rf "$dest"
    git clone --depth 1 "$url" "$dest"
  fi
  ok "$(basename "$dest") ready at $dest"
}

clone_or_update "https://github.com/badlogic/pi-skills.git" "$SKILLS_DIR/pi-skills"
clone_or_update "https://github.com/anthropics/skills.git"  "$SKILLS_DIR/anthropic-skills"

# --- 3. Done ---
cat <<EOF

Next steps:
  pi                 # start pi; skills load on demand
  /skill:brave-search  # force-load a skill
  pi config          # enable/disable resources

Installed skill repos:
  $SKILLS_DIR/pi-skills
  $SKILLS_DIR/anthropic-skills

Cloned somewhere other than ~/.piconf? Edit the skills/extensions/prompts/themes
paths in $REPO_DIR/settings.json, then re-run this script.
EOF
