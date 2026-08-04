# Design Lens

Use APOSD (A Philosophy of Software Design) as the default lens for software tasks: purpose and interface first, then invariants, dependency assumptions, non-obvious choices, and error behavior.

# Workflow

Separate planning and implementation for non-trivial work.

## Planning

1. Inspect the system and identify touch points.
2. Propose viable approaches with a recommendation.
3. Include a concise call graph showing the relevant execution path and marking planned changes.
4. Identify how the change will be verified.
5. Ask questions if necessary for clarification.

Plan implementation as a sequence of coherent, independently reviewable commits. Roughly 400 lines each is a useful default for scoping, but size by review effort: a commit should be one logical step a reviewer can understand on its own. The goal is reviewable commit boundaries, not fixed-size pauses during implementation.

High-level plans and roadmaps should stay abstract and non-prescriptive about specific implementation. Organize them by capability or milestone, not commit boundaries; commit granularity is an implementation-planning concern.

## Implementation

1. Read the relevant context and reread the active plan/spec at the direction of the user.
2. Implement the chosen approach while keeping the following in mind:
  - Write the skeleton first with comments marking each major block, then fill in the implementation. This surfaces structural issues before details obscure them.
  - Inline helpers whose body is a single expression mirroring the underlying API. Any abstraction (helper, wrapper, class) earns its existence only when it enforces an invariant, hides non-obvious complexity, or eliminates duplication callers would otherwise get wrong.
  - Do not implement fallback or defensive solutions unless explicitly requested or stated by documented requirements.
  - Prefer repo-local tmp directories over shared root-level ones.
3. Avoid broad research and planning unless new evidence invalidates the plan or surfaces a new design issue.
4. If the change drifts into a new design problem, return to planning before continuing, and update the persisted plan to match.

Structure the finished work as small, coherent commits drawn by logical cohesion, so each can be reviewed on its own.

## Review

For non-trivial implementation work, run all configured `review-*` presets in parallel after implementation and focused verification. Reconcile their findings, address material issues, and rerun affected verification before completion.

## Persisting Output

When the user asks to persist output such as plans, design notes, research, specifications, or comparisons, write through the workspace's existing `.artifacts/` path. Treat that workspace-local path as the project-scoped interface, even when it resolves into an external private repository.

If `.artifacts` is missing or broken, consult `$ARTIFACTS_PATH/SETUP.md`. Ask the user before adopting or migrating the workspace. Do not create a local replacement directory, infer a namespace, or write directly into `$ARTIFACTS_PATH` except while following an approved setup procedure. If `$ARTIFACTS_PATH` or its setup guide is unavailable, ask the user.

Prefer grouping related documents by topic or initiative:

- `.artifacts/{topic}/{title}.md` for related documents
- `.artifacts/{title}.md` for a small standalone document

Use short kebab-case names. Report the workspace-local path after writing rather than the resolved external path, then pause for review before acting on the document.

Persisted docs you are actively working from are living documents. When a decision, plan change, or completed action makes such a doc stale, update it in the same session: revise the affected sections in place rather than appending contradictions. If the user overrides something in a persisted plan, reflect that in the doc. Briefly mention each update (path and what changed).

## Completion

A task is complete only when its verification passes, or you explicitly report why verification could not be run. Define verification before starting implementation. Prefer deterministic finish lines.

## Frontend

Preserve the existing design system when one exists. Otherwise, choose an intentional visual direction and load the `frontend-design` skill when necessary.

## Commit Messages

Commit messages should be in the style of `mitchelh`:

```
<scope>: <concise lowercase description>
```
