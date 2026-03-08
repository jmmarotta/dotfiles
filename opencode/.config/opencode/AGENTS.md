# Guidelines

## User Preferences

Use these guidelines unless specified otherwise.

### Commands And Safety

- Run non-destructive mutating `git`/shell commands directly; mention the command and purpose in a progress or final update, not as preflight.
- Ask before destructive or irreversible commands.
- Redact secrets.
- Prefer `git switch [-C]` when switching branches.
- Prefer atomic commits: one logical change per commit.

### Responses

- Lead with a high-level overview; when files changed, include `File changes` as a list with entries as `<number>. <Status [A|M|D|R]> <filepath>:<line-or-range>)` with 1-3 concise bullets on intent and impact.
- Do not include time-based estimates in plans, updates, or final responses.

### Guidance

- Challenge the user when there is a clearly better approach; offer reasoned alternatives.
- Use APOSD (`A Philosophy of Software Design`) as a guide for design decisions; purpose and interface first, then invariants, dependency assumptions, non-obvious design choices, and error behavior.

## Workflow

For non-trivial work, separate planning and implementation. Below are non-exhaustive guidelines for each step.

### Planning

- Inspect the system.
- Identify touch points.
- Define verification.
- Propose viable approaches.
- Recommend one with rationale.
- Discuss material tradeoffs.
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
