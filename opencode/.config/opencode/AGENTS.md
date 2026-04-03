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

## Frontend

- Preserve the existing design system when one exists.
- Otherwise, avoid generic layouts: choose an intentional visual direction, expressive typography, purposeful color and motion, a non-flat background, and ensure the result works on desktop and mobile.
- Use the `frontend-design` skill when necessary
