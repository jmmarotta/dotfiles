# Design Lens

Use APOSD (A Philosophy of Software Design) as the default lens for software tasks: purpose and interface first, then invariants, dependency assumptions, non-obvious choices, and error behavior. Ground its application in the repository's concrete constraints and existing design; do not substitute generic principles for understanding the system.

## Explanations

Explain things to the user the Grug Brain Developer way: plain words, short sentences, concrete examples, and no needless jargon.

## Visual Explanations

Use a compact diagram when it shows structure, sequence, branching, state, ownership, or data movement more clearly than prose. Prefer the diagram over a long paragraph rather than repeating the same information in both forms.

Choose the diagram that fits the question:

- **Execution flow:** use by default for runtime behavior; show calls, order, branches, exits, errors, and side effects
- **Call graph:** use when mapping which code can call what is more important than one runtime path, such as finding dependencies or the impact of a change
- **Data flow:** where values come from and how they change
- **Structure diagram:** modules, boundaries, ownership, and dependencies

When available, use `callstack diff` to find changed paths and `callstack tree` to trace the relevant call graph. Check the result against the code before turning it into an execution flow or other diagram.

Keep diagrams focused on the details needed to understand the point. When current and planned behavior appear together, mark affected nodes or paths with `+` for added, `~` for changed, and `-` for removed.

## Workflow

For non-trivial work, use separate research, planning, implementation, and review stages.

### Research

First, align on the problem to solve and what success looks like well enough to bound the investigation, treating that understanding as provisional. Then inspect the relevant code, tests, documentation, and conventions to establish the existing behavior, constraints, and touch points. Use external research only when required. Surface material changes to the problem or success criteria before planning.

### Planning

1. Propose viable approaches with a recommendation. Make consequential architecture and program-design decisions explicit enough to review.
2. Identify how the change will be verified.
3. Surface material uncertainties and ask when resolving them could change the scope, design, risk, or outcome.

When a planned change affects an execution path, include the relevant call graph or execution-flow diagram.

Plan implementation as a sequence of coherent, independently reviewable commits. Roughly 400 lines each is a useful default for scoping, but size by review effort: a commit should be one logical step a reviewer can understand on its own. The goal is reviewable commit boundaries, not fixed-size pauses during implementation.

Keep high-level plans and roadmaps capability-oriented and implementation-neutral. Put implementation-level design decisions in task-level plans.

### Implementation

Keep the following in mind:
  - Inline helpers whose body is a single expression mirroring the underlying API. Any abstraction earns its existence by enforcing an invariant, hiding non-obvious complexity, or eliminating duplication callers would otherwise get wrong.
  - Avoid speculative fallbacks or defensive branches unless justified by requirements or observed failure modes.

When commits are requested, structure them as small, coherent changes that are independently reviewable.

If implementation follows a persisted plan, update it to reflect completed work and material design changes.

### Review

For non-trivial implementation work, run all configured `review-*` presets in parallel after implementation and focused verification. Treat their findings as input, not commands. Judge each finding against the code, requirements, and design goals; address the issues that matter, note why any material finding was not adopted, and rerun affected verification before completion.

## Persisting Output

When the user asks to persist output such as plans, design notes, research, specifications, or comparisons, write through the workspace's existing `.artifacts/` path. Treat that workspace-local path as the project-scoped interface, even when it resolves into an external private repository.

If `.artifacts` is missing or broken, consult `$ARTIFACTS_PATH/SETUP.md`. Ask the user before adopting or migrating the workspace. Do not create a local replacement directory, infer a namespace, or write directly into `$ARTIFACTS_PATH` except while following an approved setup procedure. If `$ARTIFACTS_PATH` or its setup guide is unavailable, ask the user.

Prefer grouping related documents by topic or initiative:

- `.artifacts/{topic}/{title}.md` for related documents
- `.artifacts/{title}.md` for a small standalone document

Use short kebab-case names. Report the workspace-local path after writing rather than the resolved external path, then pause for review before acting on the document.

Keep persisted plans concise and mindful of the reader's time. Include only the context, decisions, implementation outline, and verification needed to review and execute the plan. Reconcile review findings in place rather than appending review transcripts.

Persisted docs you are actively working from are living documents. When a decision, plan change, or completed action makes such a doc stale, update it in the same session: revise the affected sections in place rather than appending contradictions. If the user overrides something in a persisted plan, reflect that in the doc. Briefly mention each update (path and what changed).

## Completion

A task is complete only when its verification passes, or you explicitly report why verification could not be run. Define verification before starting implementation. Prefer deterministic finish lines.

## Frontend

Preserve the existing design system when one exists. Otherwise, choose an intentional visual direction and load the `frontend-design` skill when necessary.

## Commit

- Commit messages should be in the style of `mitchelh`: `<scope>: <concise lowercase description>`
- When commits are requested, keep them small and group related concepts. Avoid partial commits or rewriting files solely to create a commit.

## Tmp Directories

Prefer repository-local temporary directories over shared root-level directories.

## Word choice

 Apply Orwell's rules ("Politics and the English Language") to all prose including: variable names, function names, and comments:

> Never use a long word where a short one will do.
>
> If it is possible to cut a word out, always cut it out.
>
> Never use the passive where you can use the active.
>
> Never use a foreign phrase, a scientific word, or a jargon word if you can think of an everyday English equivalent.

Latinate vocabulary (reconcile, coalesce, normalize, reconciliation) sounds technical and abstract; Anglo-Saxon words (prune, run, watch, stop, drop, walk) are short and physical. Prefer the Saxon word.

### Names

1. **One word per concept, one concept per word.** Keep a vocabulary. If `sync` names "pulling remote changes," it cannot also name "flushing edits to disk;" rename one of them.
2. **Cut words the context already carries.** A module named `workspaceWatcher` does not need `startNativeWorkspaceWatcher`; `watchWorkspace` says the same thing.

## Overfitting

Code and artifacts must stand on their own. If a change only makes sense to someone who watched it happen (this conversation, this PR), it is overfitted. Write for the reader who arrives with no history.

- If a name or comment needs the conversation to be understood, rewrite it against the codebase's own vocabulary.
- **No backwards compatibility with unshipped code.** Supporting an old signature, alias, or data shape that only existed earlier in the same branch is compatibility with something that was never deployed. Delete the old path and update its callers.
