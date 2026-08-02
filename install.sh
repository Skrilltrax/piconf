#!/usr/bin/env bash
# piconf installer: symlinks config + asset dirs into ~/.pi/agent, clones skill repos.
# Location-independent — clone this repo anywhere and run.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_DIR="${PI_DIR:-$HOME/.pi/agent}"
SKILLS_DIR="$PI_DIR/skills"

log()  { printf '\033[1;34m[piconf]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[piconf]\033[0m %s\n' "$*" >&2; }
ok()   { printf '\033[1;32m[piconf]\033[0m %s\n' "$*"; }

mkdir -p "$PI_DIR" "$SKILLS_DIR"

# link_file <src> <dest>: back up any existing dest, then symlink (file or dir).
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

# --- 1. Symlink config files + asset dirs into ~/.pi/agent ---
# pi auto-discovers ~/.pi/agent/{extensions,prompts,skills,themes}, so these
# need no entries in settings.json and work from any clone location.
link_file "$REPO_DIR/settings.json" "$PI_DIR/settings.json"
link_file "$REPO_DIR/AGENTS.md"     "$PI_DIR/AGENTS.md"
for asset in extensions prompts themes; do
  link_file "$REPO_DIR/$asset" "$PI_DIR/$asset"
done

# --- 2. Clone / update skill repos (kept out of this git repo) ---
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
clone_or_update "https://github.com/obra/superpowers.git"   "$SKILLS_DIR/superpowers"
clone_or_update "https://github.com/android/skills.git"     "$SKILLS_DIR/android-skills"
clone_or_update "https://github.com/chrisbanes/skills.git"  "$SKILLS_DIR/chrisbanes-skills"

# --- 3. Symlink hand-written skills into the skills dir (alongside clones) ---
for skill_dir in "$REPO_DIR"/skills/*/; do
  [[ -d "$skill_dir" ]] || continue
  name="$(basename "${skill_dir%/}")"
  link_file "${skill_dir%/}" "$SKILLS_DIR/$name"
done

# --- 4. Done ---
cat <<EOF

Done. pi auto-discovers resources from $PI_DIR.

Installed skill repos:
  $SKILLS_DIR/pi-skills         (brave-search, browser-tools, google APIs, transcribe, vscode)
  $SKILLS_DIR/anthropic-skills  (docx/pdf/pptx/xlsx + creative/dev examples)
  $SKILLS_DIR/superpowers       (debugging, TDD, code review, planning, git worktrees)
  $SKILLS_DIR/android-skills    (Google official: Compose, navigation, perfetto, R8, ...)
  $SKILLS_DIR/chrisbanes-skills (deep Compose + Kotlin)

Next steps:
  pi                 # start pi
  /skill:<TAB>       # autocomplete available skills (e.g. /skill:git-commit)
EOF
