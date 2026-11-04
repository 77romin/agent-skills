# Edge-case checklist (select relevant cases only)

Read the contest README first. Every test case must map to a real requirement ID and have an expected outcome. Avoid spending limited contest time on unrelated categories.

## Input and API contracts
- Missing/null/empty required input; whitespace-only and Unicode text
- Invalid type, malformed JSON, unexpected fields, very long text, boundary numbers
- Missing resources, invalid identifiers, invalid query parameters, correct HTTP status
- Pagination zero/large page, sorting/filtering stability, no results

## Persistence and state
- Refresh/restart still shows previously saved state if persistence is required
- Creation/update/delete follows the specified state transition rules
- Duplicate create and repeated clicks do not create inconsistent state
- An error mid-operation leaves data consistent (transaction rollback)
- Two users cannot see or modify each other's protected records
- Clock/time-zone/date boundaries if the README involves schedules

## Concurrency — especially for booking / stock / inventory
- Two simultaneous requests compete for the last available seat/item
- Assert **at most one** successful reservation and correct final DB state when capacity is one
- Retry the winning request: check idempotency or duplicate handling as the specification requires
- Check the authoritative DB constraint/transaction, not only a frontend disabled button
- Separate an accepted request from a committed reservation, if approvals exist
- Test simultaneous approvals if approval is the final allocation step

## Browser and UI
- App loads from a fresh session; no fatal console/server errors
- Primary navigation and form submission work, including keyboard input
- Loading/error/empty states do not hide important status
- Double click, back navigation, refresh and repeated submission
- Check required browser viewport and responsive behavior only if specified

## Authentication / security (when in scope)
- Unauthenticated API requests denied appropriately
- Direct URL and API bypass of UI-only role restrictions fails
- Missing/expired token and cross-user access are handled
- Input is validated server-side; no secrets in committed files or logs

## Submission smoke test
- Install/build/start instructions work in the provided environment
- Environment variables are documented without real secrets
- Mandatory routes and core workflows pass after the final modification
- Tests report: ID | scenario | command | expected | observed | PASS/FAIL/BLOCKED
- Stop optional work early enough to satisfy deadline and submission procedure
