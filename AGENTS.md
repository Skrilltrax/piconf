# Global Agent Instructions

These apply to every pi session. Project-level `AGENTS.md` files layer on top of
this.

## Working style

- Be concise. Prefer code and commands over prose.
- State assumptions briefly before acting on them.
- Make the smallest change that solves the problem. Avoid drive-by refactors.
- Run the project's checks (lint, typecheck, tests) after code changes when they exist.

## Safety

- Never run destructive commands (rm -rf, force pushes, production migrations) without confirmation.
- Prefer read-only inspection before modifying.
- Use git for rollback: commit or stash before large changes.

## Environment

- Default shell: bash.
- Package manager / task runner: read the project's README or package.json first.
- When a command needs an API key or secret, say which environment variable it expects rather than hardcoding it.

## Skills

- Skills are loaded on demand. Use `/skill:<name>` to force-load one when relevant.
- Prefer a dedicated skill (e.g. brave-search, transcribe) over ad-hoc shell commands when it exists.
