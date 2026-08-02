---
name: debug
description: Debug problems methodically instead of guessing. Use when something fails, crashes, or behaves unexpectedly. Emphasizes reproduce, isolate, hypothesize, verify.
---

# debug

Resist the urge to patch symptoms. Find the cause first.

## Method

1. **Reproduce** reliably. Note exact steps, inputs, environment, and the full error (stack trace, logs, exit code).
2. **Isolate**. Shrink the reproducer: smaller input, fewer steps, a minimal repro script. Comment out to find what matters.
3. **Hypothesize**. State one specific cause ("X is null because Y returns early"). Predict the fix's effect *before* applying it.
4. **Verify**. Test the hypothesis with the smallest change or a probe (log, breakpoint, assertion). Confirm it changes behavior.
5. **Fix the root cause**, not the symptom. Re-run the reproducer and the full test suite.

## Tactics

- **Read the error.** The stack trace and message usually point at the cause. Don't skim.
- **Binary search** changes: `git bisect`, or disable halves of the code.
- **Check assumptions**: print types/values/lengths at the boundary where data flows in.
- **Recent change?** `git log -p <file>`, `git diff`. Regressions live near the last edit.
- **Environment diff**: works locally but not in CI? Compare versions, env vars, paths, permissions.

## Don't

- Don't change multiple things at once — you won't know what fixed it.
- Don't add a fix without a failing test that proves the bug existed.
- Don't "fix" by catching or swallowing the error unless that is genuinely correct.

## After fixing

- Add a regression test pinned to the repro.
- Note the root cause in the commit message.
- Ask: where else does this same pattern exist?
