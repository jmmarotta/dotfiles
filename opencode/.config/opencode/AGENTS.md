# Design Lens

Use APOSD (A Philosophy of Software Design) as the default lens for software tasks: purpose and interface first, then invariants, dependency assumptions, non-obvious choices, and error behavior. Load the `software-design` skill only when absolutely necessary for detailed guidance.

# Workflow

Separate planning and implementation for non-trivial work. Work is non-trivial when it spans multiple files, changes behavior, involves design tradeoffs, or needs explicit verification planning.

## Planning

1. Inspect the system and identify touch points.
2. Propose viable approaches with a recommendation.
3. Identify how the change will be verified.
4. Load the `software-planning` skill for detailed guidance.

### Persisting a Plan

Only when the user asks. Write to disk at:
- `.plans/{plan-title}.md` for standalone work
- `.plans/{project}/{plan-title}.md` when grouping related plans

`.plans/` is relative to the repo root (or cwd outside a git repo). `{project}` and `{plan-title}` are short kebab-case slugs; infer `{project}` from context. Default to flat unless a project grouping is specified or obvious.

After writing, report the path and a brief summary, then pause for approval before implementing.

When implementation is complete, suggest moving the plan to `archive/` mirroring its original path (e.g. `.plans/archive/{plan-title}.md`). Wait for confirmation before moving.

## Implementation

1. Reread the active plan/spec and relevant context.
2. Implement the chosen approach. Do not implement fallback solutions unless explicitly requested or required by a documented requirement.
3. Prefer repo-local tmp directories over shared root-level ones.
4. Avoid broad research unless new evidence invalidates the plan.
5. Load the `software-implementation` skill for detailed guidance.

## Completion

A task is complete only when its verification passes, or you explicitly report why verification could not be run. Define verification before starting implementation. Prefer deterministic finish lines.

## Frontend

Preserve the existing design system when one exists. Otherwise, choose an intentional visual direction: expressive typography, purposeful color and motion, a non-flat background, and responsive across desktop and mobile. Avoid generic layouts. Load the `frontend-design` skill when necessary.
