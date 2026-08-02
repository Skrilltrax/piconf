---
name: code-review
description: Review code changes systematically for correctness, security, performance, and style. Use when asked to review a PR, diff, or code before merging.
---

# code-review

Review the *diff*, not just the result. Judge whether the change is correct, safe, and necessary.

## Process

1. Read the PR/issue to understand intent.
2. Skim the whole diff before commenting.
3. Review file-by-file, then check integration points.
4. Mentally run the code; if risky, ask the author to verify.

## Checklist

**Correctness**
- Does it do what the message claims?
- Edge cases: empty, null, off-by-one, concurrency, large inputs.
- Error handling: are failures surfaced, not swallowed?

**Security**
- Input validation at trust boundaries.
- No secrets in code, logs, or URLs.
- Injection (SQL, shell, template), authz, path traversal.

**Performance**
- Obvious O(n^2) loops or N+1 queries.
- Unbounded loops/allocations driven by user input.

**Style & maintainability**
- Names reveal intent. Functions do one thing.
- Duplication that should be extracted.
- Tests cover the new behavior and its failure paths.
- Public API changes documented (README, changelog).

## Feedback style

- Distinguish **must-fix** (blockers) from **nits** and **suggestions**.
- Be specific: cite `file:line`, show the fix.
- Note good patterns, not just problems.

## Ship criteria

Merge when: intent is clear, blockers resolved, tests pass, and you understand how it fails.
