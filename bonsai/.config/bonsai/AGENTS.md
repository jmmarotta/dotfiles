# Working Conventions

## Workflow

Apply APOSD throughout the work. Design establishes the contract; implementation realizes and verifies it. Revisit the design when evidence exposes a problem, and scale the process to the task's uncertainty and risk.

### Design

Understand current behavior, callers, and constraints. Define or confirm interfaces and write or update their documentation before implementation starts, specifying responsibilities, inputs and outputs, guarantees, and failure behavior. Walk concrete examples through the design, including interactions and edge cases; make unresolved questions explicit.

### Implementation

Implement against the agreed interfaces, revisiting the design rather than accumulating exceptions around it. Verify changed behavior and affected interactions, and complete repository-required checks. Delegate implementation only when explicitly instructed by the user.

### Review

For material-risk changes, run all configured `review-*` presets in parallel. Review both behavior and design, considering correctness, security, performance, and compatibility.

Check APOSD red flags, increased cyclomatic complexity, and nesting. Treat them as signals to investigate, not automatic defects. Complexity can warrant a finding when it imposes a concrete comprehension or maintenance cost.

Treat automated findings as hypotheses, not instructions. Verify them against the code, intended contract, and relevant evidence; judge whether fixing them improves the result. Deduplicate findings, explain rejected material findings, and rerun affected checks.

Keep fixes within scope, bringing scope-expanding changes to the user. Prefer the smallest fix that restores the intended behavior or invariant without preserving the underlying design problem.

## Frontend

Use *Refactoring UI* as the default frontend design lens while preserving any existing design system. If none exists, choose an intentional visual direction and load the `frontend-design` skill when needed.

## Commits

Use `mitchelh` commit messages: `<scope>: <concise lowercase description>`

Do not create partial commits or rewrite files only to manufacture intermediate states.

## Pull Requests

The pull request body explains the change's design to a reviewer with no conversation history, in clear, succinct terms. Explain what problem the change solves, the behavior it changes and what stays the same, how the design achieves it, and why this design was chosen, including known limits. Include a visualization when it makes the design clearer. A verification section is unnecessary.

## Worktrees

Create Git worktrees under the primary checkout's `.worktrees/<name>/`. Remove them with `git worktree remove`.

## Records

Code and its comments are the authoritative record of the implemented system. Repository documentation, such as files under `docs/`, provides readable views of that state and must remain consistent with it.

- Code and artifacts must make sense without conversation or pull-request history. Rewrite names or comments that rely on hidden context using the codebase's vocabulary
- Keep contracts and design rationale near the code they explain
- Do not preserve compatibility with unshipped code that existed only earlier in the current branch. Delete old signatures, aliases, and data shapes; update their callers

## Artifact Setup

Use the workspace's `.artifacts` path for persisted documents and Grove work.

If the path is missing or broken, consult `$ARTIFACTS_PATH/SETUP.md`. If the guide is unavailable, ask the user. Ask before adopting or migrating the workspace. Do not create a replacement path, infer a namespace, or write directly to `$ARTIFACTS_PATH` outside an approved setup.

## Grove

Treat workspace-local paths as the project interface, even when `.artifacts` resolves elsewhere. If the Grove manifest is missing, run `grove agent setup` for the setup contract.

### Grove Issues

Issues are Markdown files with YAML frontmatter under `.artifacts`.

- Run `grove issue schema` once before working with issues
- Create issues with `grove issue create` only after user approval; do not generate IDs, UUIDs, timestamps, filenames, or bundle paths
- Preserve unknown frontmatter and supporting documents. Do not move or rename a bundle when changing its title, body, status, or priority

### Issue Content and Supporting Documents

Issues and their supporting documents describe intended designs and changes, and the work toward implementing them.

The issue explains the goal, what changes and what stays the same, the design and why it was chosen over credible alternatives, known limits, current work state, and remaining work. Organize around the problem's concepts rather than a fixed template. Reference commits and issue IDs rather than transient worktree state.

- Revise the issue in place as the work changes, keeping current decisions clear and recording material changes and their rationale
- Before context resets or handoffs, update the issue or another approved durable record with the state needed to resume
- Use a supporting document only when an existing issue covers the work and lasting detail or evidence would make its body hard to scan. Store it beside the issue with a short, kebab-case name, summarize its conclusion, and link to it from the issue

### Scratch Work

Use the repository's `.tmp` directory for throwaway files. Do not create an issue solely for scratch work.
