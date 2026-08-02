---
name: docs
description: Write and maintain documentation. Use when creating or updating READMEs, API docs, architecture notes, inline comments, or onboarding guides.
---

# docs

Docs answer the questions code can't: why it exists, how to use it, and how it fits together.

## Principles

- **Keep docs next to the code** they describe (README in the package, docstrings on the symbol). Distant docs rot.
- **Write for the reader who just arrived.** Define jargon; link to context.
- **Behavior, not implementation.** Describe what it does and when to use it, not how it's built.
- **Keep it honest.** Wrong docs are worse than none. Update docs in the same commit as the change.

## README (every project)

Minimum sections:

1. **What it is** — one paragraph.
2. **Getting started** — install + run in <= 5 commands.
3. **Usage** — the 80% case, copy-pasteable.
4. **Testing** — how to run checks.
5. **Contributing / license** — links if relevant.

Cut anything a new user doesn't need in the first five minutes.

## API docs

- Document the **contract**: inputs, outputs, errors, side effects, examples.
- Show a realistic example for every public function/endpoint.
- Call out preconditions and failure modes explicitly.

## Inline comments

- Comment the **why**. The code already shows the what.
- Delete comments that restate the code (`i++; // increment i`).
- Keep non-obvious constraints, trade-offs, and links to issues/decisions.

## Don't

- Don't document private internals in READMEs.
- Don't let a `TODO`/`FIXME` live without context (link the issue or the blocker).
- Don't generate walls of auto-docs nobody reads — link to the source instead.
