---
name: contest-webapp
description: Implement and verify a README-driven web application under a strict contest deadline. Use for timed hackathons, coding competitions and specification-to-app tasks requiring fast planning, implementation, review and QA.
---

# README-to-App Contest Workflow

Use this skill when building a web application from a supplied README under time pressure. Treat the problem README, rubric, tests and provided source as the source of truth.

## 0. Establish reality before planning
- Locate and read the actual README, test scripts, entry points, dependency manifests, current code and submission instructions.
- Ask for a missing deadline only when necessary; otherwise proceed and protect a final verification window.
- Don't assume a database, web framework, UI design, external network, or browser automation is available.
- Only use tools already available in the environment; do not fabricate tool runs.

## 1. Delegate by phase, not by headcount
- Main Codex is the orchestrator.
- Parallelize **Planner** and **QA** to independently analyze README; QA drafts acceptance tests, Planner drafts implementation plan.
- Reconcile both outputs into a Requirements Matrix: ID, README evidence, priority P0/P1/P2, acceptance criterion, implementation status, test status.
- Assign **Generator** application code ownership. Start a minimal running app quickly and implement vertical feature slices.
- Delegate **Reviewer** and **QA** after relevant code exists. Both may inspect in parallel, but neither should edit application files.
- Route actionable failures to Generator; rerun relevant tests and finally P0 regression checks.
- Delegate additional write-capable agents ONLY when file ownership is disjoint and integration costs are understood.

## 2. Prioritize for scoring
- P0: hard requirements, app starts successfully, core user journeys, explicit grading rules.
- P1: important behaviors and major error handling.
- P2: polish, nice-to-haves, unnecessary infrastructure. Defer when time is short.
- Preserve the supplied stack and contract unless the README requires a change.
- Prefer completing an end-to-end P0 journey over producing scaffolding for many half-finished features.

## 3. Acceptance tests are independent
- QA should derive tests from README, not only the Generator's design.
- Include invalid/missing inputs, duplicate requests, concurrent writes, persistence, authorization and state transitions **when relevant**.
- Refer to [edge-case-checklist.md](references/edge-case-checklist.md) and pick applicable cases; do not mindlessly run every category.
- A remaining risk is explicit: PASS (executed and verified), FAIL (executed and failed), BLOCKED (unable to execute).

## 4. Execution checkpoints
- Initial: exact build/start/test commands known; earliest runnable app launched if feasible.
- After each vertical slice: run narrow smoke tests; preserve evidence (command and result).
- After integrations: run all P0 tests; check app startup, state integrity and critical UI flows.
- Final deadline window: freeze optional work, check README submission constraints, verify no secrets, ensure reproducible startup and document unsupported tests.

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
