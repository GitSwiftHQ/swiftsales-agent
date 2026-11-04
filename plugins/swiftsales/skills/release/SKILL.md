---
name: release
description: "Walk through releasing a version with SwiftSales: status, draft, What's New, readiness, submission. Use when the user wants to release or submit a new version of one of their apps whose build is already uploaded."
---

# Release a version

Uses the SwiftSales tools on this Mac: `release_status`, `draft_review_reply`, `release_context`, `list_builds`, `prepare_release`, `set_whats_new`, `check_readiness`, `apply_release`, `submit_for_review`, `approval_status`.

## Inputs

- `app`: App key or exact name.
- `version`: Version to release, for example 1.3.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.

## Steps

Release <app> version <version> with the SwiftSales tools.
1. Call release_status for <app> to see the live version and any version in preparation. If App Review rejected it (`rejected`), follow its nextStep: the user pastes the reviewer's message, draft_review_reply drafts the reply and the fixes.
2. Call release_context and list_builds; pick the newest valid build for <version>.
3. Call prepare_release with the version, build and release type the user wants.
4. Draft What's New from this repository's changes since the last release and call set_whats_new for every locale the app already has.
5. Call check_readiness and fix what is blocking; tell the user about `needsYou` items (`notes` only when they apply to this version).
6. Call apply_release, then submit_for_review.
When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.
