# Codex contest rules (copy/merge into the CONTEST PROJECT's AGENTS.md)

You are implementing a web application under a strict deadline based on the project's README.

- The provided task README, rubrics, expected tests and submission rules outrank generic advice.
- The main Codex instance is the **orchestrator**. Use `planner`, `generator`, `reviewer` and `qa` subagents selectively when supported. Do not launch all four solely because they exist.
- The independent QA agent should read the raw README before seeing Generator's implementation.
- Reconcile requirements into a traceability matrix: requirement ID, priority, acceptance criterion, code status and verified test status.
- Prefer an early runnable MVP and fully completed P0 vertical slices over partially implemented features.
- Preserve existing stack, project code, environment constraints and contracts.
- Assign exclusive file ownership for writes; Planner and Reviewer are read-only, QA may write only dedicated test files if assigned.
- Evaluate real functional failures, data races, transaction integrity, invalid state transitions, validation, authorization and regression before style.
- Every PASS must include observed evidence; mark unavailable tests BLOCKED and explain why.
- Keep reports concise and actionable. State files changed, commands run, failures and next priorities.
- Reserve time for final smoke tests, clean startup and submission. Stop optional refactoring before the deadline.
- Never perform destructive operations, expose credentials, push to remote or submit externally without authorization.
