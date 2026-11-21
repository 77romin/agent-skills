---
name: contest-webapp
description: Implement and verify a README-driven web application under a strict contest deadline. Use for timed hackathons, coding competitions and specification-to-app tasks requiring fast planning, implementation, review and QA.
---

# README-to-App Contest Workflow

Use this skill when building a web application from a supplied README under time pressure. Treat the problem README, rubric, tests and provided source as the source of truth.

## 0. Establish reality before planning
- Locate and read the actual README, test scripts, entry points, dependency manifests, current code and submission instructions.
- If the hard deadline is not stated, ask for it once as a clock time; then protect a final verification window. Never guess the time remaining.
- When the task supplies input data (documents, datasets, logs, fixtures), audit it before designing: files by type, whether each is actually readable by the intended pipeline, and what is unread, empty or lossy. Report coverage as `read / total`.
- Don't assume a database, web framework, UI design, external network, or browser automation is available.
- Only use tools already available in the environment; do not fabricate tool runs.

## 1. Delegate by phase, not by headcount
- Main Codex is the orchestrator.
- Parallelize **Planner** and **QA** to independently analyze README; QA drafts acceptance tests, Planner drafts implementation plan.
- Planner starts with a **problem frame**: user, the job they are trying to get done, the observable success criterion, and non-goals — each marked as README evidence or assumption.
- **Grill before the gate:** batch the open questions that would change priorities (at most five, highest impact first) and ask the Tech Lead. Do not ask what the README already answers.
- Reconcile both outputs into a Requirements Matrix: ID, README evidence, priority P0/P1/P2, acceptance criterion, implementation status, test status.
- **Human approval gate:** report the problem frame (goal in one sentence, user, success criterion, non-goals), the requirements, recommended architecture/data contract, major trade-offs, critical test scenarios, input-audit coverage when data is supplied, and the proposed P0-first implementation order with **milestones and a feature-freeze time** to the user (Tech Lead). **Stop and wait for explicit approval or revisions before changing application code or installing project dependencies.**
- **Only after approval**, assign **Generator** application code ownership. Start a minimal running app quickly and implement vertical feature slices.
- Delegate **Reviewer** and **QA** after relevant code exists. Both may inspect in parallel, but neither should edit application files.
- Route actionable failures to Generator; rerun relevant tests and finally P0 regression checks.
- Delegate additional write-capable agents ONLY when file ownership is disjoint and integration costs are understood.
- Once the initial plan is approved, ordinary implementation, test execution, and routine bug fixes are autonomous. Obtain a new Tech Lead decision only for major architecture or stack changes, core data-model redesign, or removal of a P0 feature.

## 2. Prioritize for scoring
- P0: hard requirements, app starts successfully, core user journeys, explicit grading rules.
- P1: important behaviors and major error handling.
- P2: polish, nice-to-haves, unnecessary infrastructure. Defer when time is short.
- Preserve the supplied stack and contract unless the README requires a change.
- Prefer completing an end-to-end P0 journey over producing scaffolding for many half-finished features.
- **Scope gate:** work outside the approved matrix (new feature, visible gap or placeholder, an agent's suggestion) is logged with its linked requirement, priority and estimated cost before anyone starts it. P0-linked items proceed; P1 waits until every P0 is PASS; P2 or unlinked items go to a backlog until the Tech Lead decides. Visibility of a gap is not its priority.
- While any P0 is not PASS, Medium/Low findings are recorded, not fixed.

## 3. Acceptance tests are independent
- QA should derive tests from README, not only the Generator's design.
- Include invalid/missing inputs, duplicate requests, concurrent writes, persistence, authorization and state transitions **when relevant**.
- Refer to [edge-case-checklist.md](references/edge-case-checklist.md) and pick applicable cases; do not mindlessly run every category.
- A remaining risk is explicit: PASS (executed and verified), FAIL (executed and failed), BLOCKED (unable to execute).

## 4. Execution checkpoints
- Initial (before approval): read-only environment and README inspection, requirements/test plan, and Tech Lead decision. Do not start feature coding.
- After approval: run the app as early as feasible and confirm actual build/start/test commands.
- After each vertical slice: run narrow smoke tests; preserve evidence (command and result).
- After integrations: run all P0 tests; check app startup, state integrity and critical UI flows.
- At each milestone: report `time left | P0 PASS count | items at risk`; if a milestone is missed, cut scope (P2, then P1) instead of extending.
- If the user runs extra agent sessions, the orchestrator stays the single owner of scope and priority; other sessions are read-only or own disjoint files.
- Final deadline window: at the agreed freeze time stop feature work even if items remain, freeze optional work, check README submission constraints, verify no secrets, ensure reproducible startup and document unsupported tests.

## 5. Output format for orchestrator
Report compactly:

- **Progress:** R1 PASS / R2 FAIL / R3 BLOCKED
- **Executed:** exact command and result
- **Findings:** severity + concrete reproduction
- **Next:** highest-priority actionable step
- **Risks:** unresolved assumptions, unavailable tools, untested behavior

## 6. Safety
- Do not remove user files, overwrite existing configs, force-push, disclose secrets, or submit externally without the user's permission.
- Don't invent test results.
- Respect the contest's permitted AI/tool rules and instructions.
