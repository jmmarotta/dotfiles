# Working Conventions

## Workflow

For work with material uncertainty, design, or risk, distinguish research, design, implementation planning, implementation, and review. These describe responsibilities, not a rigid sequence or mandatory ceremony. Keep the process proportional to the task and revisit decisions when evidence changes.

Stages are not automatic approval gates. Continue within the authorized scope, pausing when a consequential decision requires user input.

### Research

Define the problem and success criteria enough to bound the investigation. Treat that view as provisional. Inspect relevant code, tests, documentation, and conventions to learn current behavior, constraints, and touch points. Note workspace state that affects the baseline, such as uncommitted changes. Use external research only when needed. Before design discussion, surface findings that materially change the problem or success criteria. For facts on which consequential choices depend, distinguish what the evidence establishes, what is inferred, and what remains unknown; identify which decisions those uncertainties affect.

Use the `research` task for web access.

### Design

Make collaboration and shared understanding central to the design process, not a final approval step. Ground consequential decisions in the intended behavior, relevant state, constraints, and trust boundaries. Use *A Philosophy of Software Design* to compare approaches by where complexity lives, what callers must understand, and how widely future changes would spread.

Design for current callers and stated requirements. Note likely extensions instead of building for them.

Before presenting a design or calling it settled, walk concrete examples through it: each affected surface or caller, places where different cases meet, and edge inputs such as empty, minimum, and maximum values. List anything unspecified as an open question instead of declaring the design complete.

### Implementation Planning

Use an implementation plan when it helps organize the work. Build it from the settled design, and update it as the work progresses. Planning explains how to realize the design; it does not replace design discussion. If it exposes a consequential decision, discuss it with the user unless they have delegated that decision.

- State the goal, material constraints, chosen design, and reasons
- Identify the main implementation touch points and how they interact, distinguishing existing behavior from proposed changes. Use visuals when they clarify the plan
- Organize delivery into coherent, independently reviewable steps, with checks tied to expected behavior
- Keep each decision's rationale in one place; link to it rather than repeat it

### Implementation

- Avoid speculative fallbacks or defensive branches unless requirements or observed failure modes justify them
- Delegate implementation only when explicitly instructed by the user
- Discuss changes to agreed guarantees, trust boundaries, state ownership, or failure behavior before adopting them, unless the user has delegated those decisions. Explain material departures at handoff

### Review

Run all configured `review-*` task presets in parallel when the change carries material risk. Consider correctness, security, performance, compatibility, and how widely a failure could spread. Mechanical or low-impact changes do not require delegated review.

Review findings are evidence for a decision.

- Check changed code for APOSD red flags, high or increased cyclomatic complexity, and nesting. Treat these as signals and elevate them when they support a demonstrated risk
- Report findings with a concrete, reachable failure, violated requirement, regression, or material risk. Include the relevant code path
- Keep findings within the change's scope, except for critical security, data-loss, or correctness risks
- Verify each finding against the code, requirements, and supported contract. Adopt it when the demonstrated risk justifies the added complexity
- Prefer the smallest fix that restores the intended behavior or invariant
- Deduplicate parallel reviews, explain rejected material findings, and rerun checks affected by adopted changes

## Frontend

Use *Refactoring UI* as the default frontend design lens while preserving any existing design system. If none exists, choose an intentional visual direction and load the `frontend-design` skill when needed.

## Commits

Use `mitchelh` commit messages: `<scope>: <concise lowercase description>`

Do not create partial commits or rewrite files only to manufacture intermediate states.

## Pull Requests

The pull request body explains the change's design to a reviewer with no conversation history, in clear, succinct terms. Explain what problem the change solves, the behavior it changes and what stays the same, how the design achieves it, and why this design was chosen, including known limits. Include a visualization when it makes the design clearer.

## Worktrees

Create Git worktrees under the primary checkout's `.worktrees/<name>/`. Remove them with `git worktree remove`.

## Overfitting

Code and artifacts must make sense without conversation or pull-request history.

- Rewrite names or comments that rely on hidden context using the codebase's vocabulary
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

The issue body is a clear, succinct, durable record of the work's design. Write for a reader with no conversation history. Explain the goal and what the work will achieve, the behavior it changes and what stays the same, how the design achieves the goal, and why this design was chosen over credible alternatives, including its known limits. Record the current state and remaining work, in terms that stay true, such as commits and issue IDs, rather than worktree status. Organize around the problem's concepts rather than a fixed template, and give each decision one clear home.

- Use a supporting document only when lasting detail or evidence would make the issue hard to scan. Store it beside the issue with a short, kebab-case name. Summarize its conclusion and link to it from the issue
- Write a supporting document only when an issue already covers the work
- Revise the issue in place as the work changes
- Pause for approval when a proposed change would alter the agreed outcome, scope, or risk. Otherwise, proceed within the approved scope and record material design changes in the issue

### Scratch Work

Use the repository's `.tmp` directory for throwaway files. Do not create an issue solely for scratch work.
