---
name: perf
description: Improve performance with evidence, not guessing. Use when something is slow, profiling, optimizing, or choosing data structures and algorithms.
---

# perf

Measure first, always. Intuition about performance is usually wrong.

## Method

1. **Set a target.** "Under 200ms p95" beats "make it faster." Without a number you can't know when to stop.
2. **Measure the baseline** with a profiler, benchmark, or telemetry on the real workload (representative inputs and environment).
3. **Find the bottleneck.** 80% of time is in 20% of code. CPU? I/O? allocations? lock contention? network?
4. **Isolate** the change. Optimize one thing, re-measure. Keep a control.
5. **Stop** when you hit the target or returns diminish.

## Tactics

- Pick the right **data structure and algorithm** first — biggest wins, least risk.
- Reduce work: cache, memoize, precompute; avoid repeated computation in loops.
- Batch I/O; avoid N+1 queries; lazy-load where it helps.
- Move work out of hot paths; hoist invariants; short-circuit early.

## Trade-offs

- Every optimization adds complexity. Is the speedup worth the maintenance cost?
- Space vs time, latency vs throughput, accuracy vs speed — state the choice explicitly.
- Don't sacrifice correctness or readability for a microbenchmark that won't show up in production.

## Don't

- Don't optimize without a measurement showing it matters.
- Don't micro-optimize cold paths.
- Don't trust a benchmark run once — noise is real; run many, watch variance.
- Don't ship a "fast" version that's also subtly wrong.

## After

- Re-measure end-to-end on the real workload.
- Keep the benchmark in the repo so the win doesn't silently regress.
- Note the before/after numbers in the commit message.
