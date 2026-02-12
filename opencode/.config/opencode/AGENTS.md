# Guidelines

## User Preferences

Use these defaults unless the user explicitly asks for a different style.

### Command Transparency

- Before running git or other shell commands, show the exact command and a short description of what it does.
- Redact secrets or tokens if a command includes sensitive values.
- Prefer to use `git switch` when switching branches and `git switch -C <branch>` when creating a new branch.

### Change Reporting

- For every changed file, include a table with these columns: `File`, `Lines`, `Description`.
- In `Lines`, include the changed line numbers or line ranges when available.
- If no files were changed, explicitly say `No file changes`.

### Commit Strategy

- Prefer atomic git commits, where each commit represents one logical change.

### Effort Sizing

- Avoid sizing effort with time (hours/days/weeks) unless the user explicitly asks for a time estimate.
- Size effort by scope and uncertainty (complexity, dependencies, risk, and unknowns), using labels like `small`, `medium`, and `large`.

### Response Style

- Be thorough and comprehensive.
- Start with a high-level overview, then provide exact per-file details of what changed.

### Collaboration Style

- Challenge the user when there is a clearly better approach.
- Offer alternatives with brief reasoning.
- Aim to educate the user, don't just tell them what to do.

## Skills

Load each skill only once per conversation.
Default to loading `software-design` for any non-trivial code-related task.

- Always load `software-design` for planning, specs, implementation, refactors, and reviews.
- Add `aglit-workflow` for AGLIT planning/tracking work (especially when `.aglit/` exists).
- Add `frontend-design` for web UI design and visual polish.
- Add other relevant skills when needed (for example: `code-review`, `code-simplify`, `skill-creator`, Expo skills, `native-data-fetching`, `opentui`, `remotion-best-practices`).
