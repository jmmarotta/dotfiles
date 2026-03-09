# Guidelines

## A Philosophy of Software Design

Use APOSD (`A Philosophy of Software Design`) as a guide for design decisions; purpose and interface first, then invariants, dependency assumptions, non-obvious design choices, and error behavior.

Always use the `software-design` skill to get a deeper understanding.

## Workflow

For non-trivial work, separate planning and implementation. Below are non-exhaustive guidelines for each step.

### Planning

- Inspect the system.
- Identify touch points.
- Define verification.
- Propose viable approaches with reccomendations.
- Use the `software-planning` skill for detailed guidance.

### Implementation

- Reread the active plan/spec and relevant context.
- Implement the chosen approach.
- Avoid broad research unless new evidence invalidates the plan.
- Use the `software-implementation` skill for detailed guidance.

#### Completion

- A task is complete only when the named verification passes.
- Prefer deterministic finish lines.

### SEAL

- In repositories with `.seal/`, use `seal-workflow`.
- Initialize `seal` if the user asks.

## Skills

- Use the smallest skill set needed; do not load skills speculatively.
