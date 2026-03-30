# A Philosophy of Software Design

Use APOSD (`A Philosophy of Software Design`) as a guide for design decisions; purpose and interface first, then invariants, dependency assumptions, non-obvious design choices, and error behavior.

Use `software-design` as the default lens for software tasks.

# Workflow

For non-trivial work, separate planning and implementation.
Treat work as non-trivial when it spans multiple files, changes behavior, involves design tradeoffs, or needs explicit verification planning.
Below are non-exhaustive guidelines for each step.

## Planning

- Inspect the system.
- Identify touch points.
- Define verification.
- Propose viable approaches with recommendations.
- Use the `software-planning` skill for detailed guidance.

## Implementation

- Reread the active plan/spec and relevant context.
- Implement the chosen approach.
- Do not implement fallback solutions unless the user explicitly asks for them or a documented requirement requires them.
- Prefer repo-local tmp directories over shared root-level tmp directories when that fits the task.
- Avoid broad research unless new evidence invalidates the plan.
- Use the `software-implementation` skill for detailed guidance.

### Completion

- Before implementation, define verification.
- A task is complete only when that verification passes, or when you explicitly report why it could not be run.
- Prefer deterministic finish lines.

## OpenPlan

- In repositories with `.plans/` or `.plans/openplan.jsonc`, use `openplan`.
- Initialize OpenPlan with `openplan init` if the user asks.

# Context Gathering

- Use `llm-tldr` when broad repo understanding, semantic code search, symbol context, or change-impact analysis would help.
- Prefer direct file reads and standard search when the target file or 1-2 symbols are already known.
