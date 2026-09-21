# Working Conventions

## Workflow

For work with material uncertainty, design, or risk, distinguish research, design, implementation planning, implementation, and review. These describe responsibilities, not a rigid sequence or mandatory ceremony. Keep the process proportional to the task and revisit decisions when evidence changes.

Stages are not automatic approval gates. Continue within the authorized scope, pausing when a consequential decision requires user input or an applicable understanding check requires a response.

### Research

Define the problem and success criteria enough to bound the investigation. Treat that view as provisional. Inspect relevant code, tests, documentation, and conventions to learn current behavior, constraints, and touch points. Use external research only when needed. Before design discussion, surface findings that materially change the problem or success criteria. For facts on which consequential choices depend, distinguish what the evidence establishes, what is inferred, and what remains unknown; identify which decisions those uncertainties affect.

When available, use `callstack diff` to find changed paths and `callstack tree` to trace call relationships. Verify the output against the code before using it.

Use the `research` task for web access.

### Design

Before choosing mechanisms, establish the relevant actors, state, constraints, trust boundaries, and properties that must remain true. Use these to evaluate alternatives rather than starting from a preferred architecture.

Develop the design collaboratively unless the user has authorized independent design decisions. Establish the consequential mechanisms, tradeoffs, and expected behavior before translating them into execution steps. Compare credible alternatives and resolve consequential uncertainties.

### Implementation Planning

Draft and maintain the implementation plan from the resulting design. The plan records how to realize the design; it is not a substitute for design discussion. If planning exposes unresolved consequential decisions, return to design discussion unless the user has authorized the agent to make those decisions independently.

- Start with a concise account of the goal, material constraints, chosen design, and reasons
- Identify the main implementation touch points and how they interact, distinguishing existing behavior from proposed changes. Use focused diagrams, flows, call graphs, or pseudocode when they clarify the shape of the implementation better than prose alone
- Follow with ordered delivery steps and useful checks tied to expected behavior; make each step one coherent, independently reviewable concept
- Keep high-level plans capability-oriented and implementation-neutral; put concrete contracts and design decisions in task-level plans
- Keep each decision's rationale in one clear home rather than duplicating it across artifacts

### Design Understanding

For substantial work involving unfamiliar, consequential design, establish understanding before implementation unless the user has authorized proceeding without understanding checks. Scale the effort to conceptual novelty, consequences, and understanding already demonstrated, not file count or lines changed. Routine, already-understood changes and disposable, isolated, low-consequence experiments do not require understanding checks.

When the user has enough context and it would help develop their reasoning, invite a tentative approach or prediction before presenting a recommendation. Treat uncertainty as useful information, not a failure. Do not withhold needed explanations or require the user to invent a solution independently.

Explain and discuss before checking understanding. Ask a few focused, open-ended questions, one at a time, using the user's reasoning to identify what needs further attention. Do not require manual implementation, exact names, line-level recall, or repetition of reasoning already demonstrated.

Check answers against the design and available evidence. Distinguish misunderstandings from inadequate explanations and unresolved design problems. Address gaps through focused explanation, a different representation, or further investigation, then revisit only what remains unclear.

When an understanding check requires a response, wait rather than continuing into implementation. Once critical gaps are resolved and the user is ready, proceed autonomously within the agreed design. This is an explicit exception to the default of continuing directly through implementation. Honor a subsequent request to skip checks without treating it as evidence of understanding or authorization to decide unresolved design questions.

After implementation, help the user connect the system as built to the design they understood. Explain consequential changes, discoveries, and implementation decisions, including those that followed the design but only became concrete during implementation. Use relevant code locations and verification evidence to make behavior, guarantees, and limitations understandable rather than recounting every edit.

Let the user's demonstrated understanding guide further discussion. Where consequential gaps remain, explain first, then use focused, open-ended questions to help the user reconstruct or apply the actual behavior. Do not require a separate review ceremony or repeat reasoning already demonstrated. If the user has authorized proceeding without understanding checks, provide a concise handoff without requiring one.

Distinguish implementation and verification status from the status of shared understanding when they differ. Do not imply that an outstanding understanding check is complete merely because implementation and verification are finished.

### Implementation

- Avoid speculative fallbacks or defensive branches unless requirements or observed failure modes justify them
- Delegate implementation to other agents only when explicitly instructed by the user
- When following a persisted plan, update it with completed work and material design changes
- Make routine implementation decisions independently. Before adopting changes that materially alter the agreed guarantees, trust boundaries, state ownership, or failure behavior, return to design discussion unless the user has authorized the agent to make those decisions independently. Explain material departures at handoff

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

The issue body is a concise, durable account of the work. Write for a reader with no conversation history. Include the goal, settled design and its key reasons, current state, and enough context to review the design later. Organize around the problem's concepts and give each decision one clear home.

- Use a supporting document only when lasting detail or evidence would make the issue hard to scan. Store it beside the issue with a short, kebab-case name. Summarize its conclusion and link to it from the issue
- Write a supporting document only when an issue already covers the work
- Revise the issue in place as the work changes
- Pause for approval when a proposed change would alter the agreed outcome, scope, or risk. Otherwise, proceed within the approved scope and record material design changes in the issue

### Scratch Work

Use the repository's `.tmp` directory for throwaway files. Do not create an issue solely for scratch work.
