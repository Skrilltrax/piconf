---
name: refactor
description: Refactor code safely without changing behavior. Use when improving structure, extracting functions, renaming, or simplifying. Behavior must stay identical.
---

# refactor

Refactoring changes structure, not behavior. Tests stay green the whole time.

## Prerequisites

- **Green tests exist** (or add characterization tests first). No tests, no refactor — only archaeology.
- Work on a clean tree so you can `git diff` and revert easily.

## Method

1. **Plan** the end state in one sentence. If you can't, you're exploring — make it work first.
2. **Tiny steps**, each leaving the code working and tests green:
   - Extract a function -> run tests.
   - Rename one symbol -> run tests.
   - Inline a trivial abstraction -> run tests.
3. **Commit between steps.** Each commit compiles and passes. Easy to review and revert.
4. **Stop when the goal is met.** Don't gold-plate.

## Safe transforms (prefer these)

- Extract function / inline function
- Rename (use IDE/symbol-aware tools, never find-replace)
- Extract a variable for clarity
- Collapse nested conditionals / guard clauses
- Replace magic numbers with named constants

## Keep behavior identical

- No logic changes in a refactor commit. Bug fixes go in their own commit.
- No format-only churn mixed with renames — it hides the real change in diffs.
- Watch for: signature changes, side-effect ordering, float/null/undefined edge cases.

## Don't

- Don't refactor and fix in the same commit.
- Don't refactor without tests passing before and after.
- Don't rename via global text replace on identifiers that appear in strings or config.

## After

- Run the full suite (not just the touched tests).
- `git diff` the final result: it should read as a clear, minimal structural change.
