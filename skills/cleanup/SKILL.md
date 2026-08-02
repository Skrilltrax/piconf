---
name: cleanup
description: Pay down technical debt systematically and safely. Use to remove dead code, duplication, unused dependencies, stale TODOs, and accumulated cruft.
---

# cleanup

Cleanup is refactoring's cousin: removing what doesn't earn its place. Same rule — behavior stays identical.

## Find targets

- **Dead code**: unused functions, unreachable branches, commented-out blocks, flags always on/off. Confirm with usage search and test coverage.
- **Duplication**: copy-pasted logic, parallel structures, near-identical functions.
- **Unused dependencies**: imports, packages, dev tooling nobody runs.
- **Stale debt**: `TODO`/`FIXME`/`HACK` with no owner, no issue, or already resolved.
- **Cruft**: old config, leftover migration scripts, generated files checked in.

## Method

1. **Make a list** ranked by risk and payoff. Delete the safe wins first.
2. **One concern per commit** (e.g., "remove unused X module", "drop unused dep Y").
3. **Verify** after each: build, full test suite, grep for lingering references.
4. **Update docs and config** that referenced the removed code.

## Prioritize

- High payoff, low risk: unused deps, dead branches, commented code -> do first.
- Low payoff, high risk: core logic, public API -> leave, or schedule a dedicated task.

## Don't

- Don't delete code "just in case it's unused" without confirming (search, tests, dynamic analysis).
- Don't delete a dependency without checking build, test, and runtime.
- Don't bundle cleanup into a feature or fix commit — it hides intent and blocks review.
- Don't remove `TODO`s without understanding why they were left; resolve or re-file them.

## After

- `git diff` should read as pure deletion or pure consolidation.
- Note what was removed and why in the commit message.
- If something hurts later, `git revert` brings it back cleanly.
