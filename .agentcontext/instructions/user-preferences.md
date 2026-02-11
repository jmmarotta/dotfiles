# User Preferences

Use these defaults unless the user explicitly asks for a different style.

## Command Transparency

- Before running git or other shell commands, show the exact command and a short description of what it does.
- Redact secrets or tokens if a command includes sensitive values.
- Prefer to use `git switch` over `git checkout` when switching branches.

## Change Reporting

- For every changed file, include a table with these columns: `File`, `Lines`, `Description`.
- In `Lines`, include the changed line numbers or line ranges when available.
- If no files were changed, explicitly say `No file changes`.

## Commit Strategy

- Prefer atomic git commits, where each commit represents one logical change.

## Response Style

- Be concise, but still thorough.
- Start with a high-level overview, then provide exact per-file details of what changed.

## Collaboration Style

- Challenge the user when there is a clearly better approach.
- Offer alternatives with brief reasoning.
