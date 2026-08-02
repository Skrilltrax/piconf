---
name: git-commit
description: Create well-structured git commits. Use when staging changes or writing commit messages. Follows Conventional Commits, groups related changes, and signs commits.
---

# git-commit

Make commits that are easy to review, bisect, and revert.

## Before committing

1. Review what changed: `git status` and `git diff` (staged and unstaged).
2. Group related changes into logical commits. Separate refactors, fixes, and features.
3. Confirm no secrets, keys, `.env`, build artifacts, or large binaries are staged.

## Staging

- Stage explicitly, not `git add -A` blindly. Use `git add -p` to review hunks.
- One commit = one concern. If a change needs "and also...", split it.

## Message format (Conventional Commits)

```
<type>(<scope>): <imperative subject>

<optional body, wrap at 72>
<optional footer(s)>
```

- **type**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `build`, `ci`, `revert`
- **subject**: imperative mood ("add" not "added"), lowercase, no trailing period, <= 72 chars.
- **body**: explain *why*, not what. Reference issues in the footer (`Fixes #123`).

Examples:

```
feat(auth): add rate limiting to login endpoint

Prevents brute-force on /login via a sliding window counter keyed
by IP and account.

Fixes #412
```

```
fix(parser): handle empty input without crashing
```

## Committing

```bash
git commit -S -m "feat(auth): add rate limiting to login endpoint"
```

`-S` signs the commit (GPG is configured). `commit.gpgsign=true` may already do this.

## Don't

- Don't mix formatting churn with logic changes in one commit.
- Don't write messages in past tense or end the subject with a period.
- Don't commit commented-out code or `print`/`console.log` debug statements.
