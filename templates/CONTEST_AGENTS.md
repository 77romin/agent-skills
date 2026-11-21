# Codex contest rules (copy/merge into the CONTEST PROJECT's AGENTS.md)

You are implementing a web application under a strict deadline based on the project's README.

- The provided task README, rubrics, expected tests and submission rules outrank generic advice.
- The main Codex instance is the **orchestrator**. Use `planner`, `generator`, `reviewer` and `qa` subagents selectively when supported. Do not launch all four solely because they exist.
- The independent QA agent should read the raw README before seeing Generator's implementation.
- Reconcile requirements into a traceability matrix: requirement ID, priority, acceptance criterion, code status and verified test status.
- Before the requirement list, write a problem frame: user, the job to be done, the observable success criterion, and non-goals. Ask the Tech Lead the few open questions that would change priorities, in one batch.
- If the deadline is not stated, ask for it once. If the task supplies input data, audit it (files by type, readable or not, coverage `read / total`) before designing on top of it.
- **Human-in-the-loop gate:** after initial README/QA analysis, present the problem frame, milestones with a feature-freeze time, priorities, proposed stack/architecture and alternatives, API/data contracts, edge cases and implementation order to the user (Tech Lead); **wait for user approval before changing application code or installing dependencies**.
- Once approved, implement and fix routine errors autonomously. Seek a new Tech Lead decision for major stack/architecture changes, a fundamental data model redesign, or dropping a P0 requirement.
- Prefer an early runnable MVP and fully completed P0 vertical slices over partially implemented features.
- **Scope gate:** work outside the approved matrix is logged with linked requirement, priority and estimated cost before anyone starts it; P2 or unlinked items wait in a backlog for a Tech Lead decision. A visible gap is not automatically an important one.
- The orchestrator is the single owner of scope and priority, including when extra agent sessions are running.
- Preserve existing stack, project code, environment constraints and contracts.
- Assign exclusive file ownership for writes; Planner and Reviewer are read-only, QA may write only dedicated test files if assigned.
- Evaluate real functional failures, data races, transaction integrity, invalid state transitions, validation, authorization and regression before style.
- Every PASS must include observed evidence; mark unavailable tests BLOCKED and explain why.
- Keep reports concise and actionable. State files changed, commands run, failures and next priorities.
- Reserve time for final smoke tests, clean startup and submission. Stop optional refactoring before the deadline.
- Never perform destructive operations, expose credentials, push to remote or submit externally without authorization.
