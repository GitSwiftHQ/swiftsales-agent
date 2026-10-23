---
name: whats-new
description: "Draft What's New from the repository's changes for every required locale. Use when the user asks for release notes or What's New text for an app version."
---

# Write What's New

Uses the SwiftSales tools on this Mac: `release_context`, `get_release_draft`, `prepare_release`, `set_whats_new`, `approval_status`.

## Inputs

- `app`: App key or exact name.
- `version`: Version, for example 1.3.
- `locales` (optional): Comma-separated locales; default: every locale the app has.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.

## Steps

Write What's New for <app> <version>.
1. Call release_context for <app>: locales, the last three versions' notes and the length limits.
2. Read this repository's changes since the last release and write short, user-facing notes in the style of the past ones, for these locales: <locales>.
3. Call get_release_draft (or prepare_release) and then set_whats_new with every locale at once.
When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.
