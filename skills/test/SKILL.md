---
name: test
description: Design and write effective tests. Use when adding tests, choosing what to cover, fixing test failures, or adopting a testing strategy.
---

# test

Test behavior, not implementation. Fast, independent, with obvious failures.

## What to test

- **Public behavior**, not private internals. Refactors shouldn't break tests.
- **Boundaries**: one test per meaningful input class — happy path, edge cases, errors.
- Edge cases: empty, null, zero, one, many, max, unicode, concurrency, failure injection.
- **Regressions**: when you fix a bug, add a test that fails before the fix.

## Structure (Arrange-Act-Assert)

```
// given
// when
// then
```

One logical assertion per test. If it needs "and also", split the test.

## Naming

Name tests by **behavior**, not `test1`:

- `it rejects expired tokens`
- `returns_404_for_unknown_user`

A failing name should explain what broke.

## Quality

- **Fast**: unit tests in milliseconds. Keep slow/integration tests in a separate suite.
- **Independent & idempotent**: order and reruns don't matter. Set up and tear down state.
- **Obvious**: a failure points at the cause. Use clear asserts and messages.
- **Minimal**: stub only collaborators you don't own; use the real thing when it's cheap.

## TDD

Use it when the problem is well-specified but the design is unclear:

1. Write the smallest failing test.
2. Make it pass with the least code.
3. Refactor.

Skip TDD for exploration/spikes; add characterization tests once the design settles.

## Don't

- Don't test the framework or the language. Test your logic.
- Don't assert on mock call counts unless that interaction is the contract.
- Don't catch and ignore assertion errors to "keep the suite green".
