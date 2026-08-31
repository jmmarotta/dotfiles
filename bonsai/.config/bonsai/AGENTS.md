# Design Lens

Apply *A Philosophy of Software Design* to the repository's concrete design and constraints. Start with purpose and interface, then examine invariants, dependency assumptions, non-obvious choices, and error behavior.

## Visual Explanations

Let diagrams carry the explanation. Add only the prose needed to read them.

Choose the diagram that fits the question:

- **Structure:** modules, boundaries, ownership, and dependencies
- **Data flow:** where values come from and how they change
- **Execution flow:** runtime order, branches, exits, errors, and side effects
- **Call graph:** what can call what and how far a change reaches

When available, use `callstack diff` to find changed paths and `callstack tree`
to trace call graphs. Check the result against the code before drawing from it.

Keep diagrams focused on the details needed to understand the point. When
current and planned behavior appear together, mark affected nodes or paths
with `+` for added, `~` for changed, and `-` for removed.

## Workflow

For work with material uncertainty, design, or risk, separate research, planning, implementation, and review. Keep each stage as light as the task allows.

### Research

Define the problem and success criteria enough to bound the investigation. Treat that view as provisional. Inspect relevant code, tests, documentation, and conventions to learn current behavior, constraints, and touch points. Use external research only when needed. Before planning, surface findings that materially change the problem or success criteria.

### Planning

Treat a plan as a concise design narrative followed by the steps needed to deliver it.

- Start with the goal and material constraints. Explain the chosen design through the problem's concepts, placing each reason with its decision
- Compare only viable alternatives. Surface open questions that could change scope, design, risk, or outcome
- End with ordered delivery steps and useful checks. Make each step one coherent, independently reviewable concept
- Keep high-level plans capability-oriented and implementation-neutral. Put concrete contracts and design decisions in task-level plans

### Implementation

- Inline single-expression helpers that only mirror an underlying API. Add abstractions only when they enforce an invariant, hide non-obvious complexity, or remove duplication callers would otherwise get wrong
- Avoid speculative fallbacks or defensive branches unless requirements or observed failure modes justify them
- When following a persisted plan, update it with completed work and material design changes

### Review

Run all configured `review-*` presets in parallel when changes span modules, alter architecture, or carry material correctness, security, or performance risk.

Review findings are evidence for a decision.

- Check changed code for APOSD red flags, high or increased cyclomatic complexity, and nesting. Treat these as signals and elevate them when they support a demonstrated risk
- Report findings with a concrete, reachable failure, violated requirement, regression, or material risk. Include the relevant code path
- Keep findings within the change's scope, except for critical security, data-loss, or correctness risks
- Verify each finding against the code, requirements, and supported contract. Adopt it when the demonstrated risk justifies the added complexity
- Prefer the smallest fix that restores the intended behavior or invariant
- Deduplicate parallel reviews, explain rejected material findings, and rerun checks affected by adopted changes

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

The issue body is a concise, durable account of the work. Write for a reader with no conversation history. Include the goal, settled design and its key reasons, current state, and enough context to review the design later. Organize around the problem's concepts and give each decision one clear home.

- Use a supporting document only when lasting detail or evidence would make the issue hard to scan. Store it beside the issue with a short, kebab-case name. Summarize its conclusion and link to it from the issue
- Write a supporting document only when an issue already covers the work
- Revise the issue in place as the work changes
- After materially changing a plan or design, report the issue path and pause for review

### Scratch Work

Use the repository's `.tmp` directory for throwaway files. Do not create an issue solely for scratch work.

## Frontend

Use *Refactoring UI* as the default frontend design lens while preserving any existing design system. If none exists, choose an intentional visual direction and load the `frontend-design` skill when needed.

## Commits

Use `mitchelh` commit messages: `<scope>: <concise lowercase description>`

Do not create partial commits or rewrite files only to manufacture intermediate states.

## Worktrees

Create Git worktrees under the primary checkout's `.worktrees/<name>/`. Remove them with `git worktree remove`.

## Word Choice

Apply Orwell's rules throughout: use short, familiar words, cut needless words, prefer active voice, and avoid jargon when plain words work.

### Names

- Use one word per concept and one concept per word
- Cut words the context already carries

## Overfitting

Code and artifacts must make sense without conversation or pull-request history.

- Rewrite names or comments that rely on hidden context using the codebase's vocabulary
- Do not preserve compatibility with unshipped code that existed only earlier in the current branch. Delete old signatures, aliases, and data shapes; update their callers
