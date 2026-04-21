# Design Lens

Use APOSD (A Philosophy of Software Design) as the default lens for software tasks: purpose and interface first, then invariants, dependency assumptions, non-obvious choices, and error behavior.

# Workflow

Separate planning and implementation for non-trivial work.

## Planning

1. Inspect the system and identify touch points.
2. Propose viable approaches with a recommendation.
3. Identify how the change will be verified.
4. Ask questions if necessary for clarification.

## Implementation

1. Read the relevant context and reread the active plan/spec at the direction of the user.
2. Implement the chosen approach while keeping the following in mind:
  - Write the skeleton first with comments marking each major block, then fill in the implementation. This surfaces structural issues before details obscure them.
  - Inline helpers whose body is a single expression mirroring the underlying API. Any abstraction (helper, wrapper, class) earns its existence only when it enforces an invariant, hides non-obvious complexity, or eliminates duplication callers would otherwise get wrong.
  - Do not implement fallback solutions unless explicitly requested or required by a documented requirement.
  - Prefer repo-local tmp directories over shared root-level ones.
3. Avoid broad research and planning unless new evidence invalidates the plan or surfaces a new design issue.
4. If the change drifts into a new design problem, return to planning before continuing.

## Persisting Output

When the user asks to persist output (plans, design notes, research, specs, comparisons), write to `.draft/` relative to the repo root (or cwd outside a git repo).

- `.draft/{title}.md` for standalone artifacts
- `.draft/{project}/{title}.md` when grouping related artifacts

Use short kebab-case slugs. Default to flat unless a project grouping is specified or obvious. Report the path and a brief summary after writing, then pause for review before acting on it.

## Completion

A task is complete only when its verification passes, or you explicitly report why verification could not be run. Define verification before starting implementation. Prefer deterministic finish lines.

## Frontend

Preserve the existing design system when one exists. Otherwise, choose an intentional visual direction and load the `frontend-design` skill when necessary.
