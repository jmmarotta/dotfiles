# Guidelines

## User Preferences

Use these defaults unless the user explicitly asks for a different style.

- For non-destructive mutating git/shell commands, execute directly and include the command plus a short purpose in a progress or final update (not as a preflight step).
- For destructive or irreversible commands, ask for explicit user confirmation before execution.
- Redact secrets or tokens if a command includes sensitive values.
- Prefer `git switch [-C]` when switching branches.
- Prefer atomic git commits, where each commit represents one logical change.

- Start with a high-level overview, then provide exact per-file details of what changed or what we are changing.
- In the final response, include a `File changes` heading, then list each changed file in this format: `1. <Status> <filepath>:<line-or-range> (<symbol anchors optional>)`.
- Under each file entry, include concise bullets describing intent and impact (typically 1-3; add more only when needed for clarity).
- Use status codes: `A` (added), `M` (modified), `D` (deleted), `R` (renamed).
- Prefer exact line numbers or ranges; if unavailable, include the closest symbol or section anchors.

- Do not include time-based estimates in plans, updates, or final responses.

- Be concise, but thorough and comprehensive.
- Challenge the user when there is a clearly better approach.
- Offer alternatives with reasoning.

- For non-trivial tasks, discuss the approach with the user before implementation.
- If a plan should be persisted, write it to an AGLIT issue or project for user review instead of only describing it in chat.

- Produce module documentation using APOSD (A Philosophy of Software Design) guidance: document the module's purpose and interface first, capture invariants and dependency assumptions, call out non-obvious design decisions and error behavior, and avoid line-by-line implementation narration.

## Skills

Load each skill only once per conversation.
Default to loading `software-design` for any non-trivial code-related task.

- Always load `software-design` for planning, specs, implementation, refactors, and reviews.
- Add `aglit-workflow` for AGLIT planning/tracking work (especially when `.aglit/` exists).
- Add `frontend-design` for web UI design and visual polish.
- Add other relevant skills when needed (for example: `code-review`, `code-simplify`, `skill-creator`, Expo skills, `native-data-fetching`, `opentui`, `remotion-best-practices`).
