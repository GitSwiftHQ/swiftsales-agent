---
name: whats-new
description: "Draft What's New from the repository's changes for every required locale. Use when the user asks for release notes or What's New text for an app version."
---

# Write What's New

Write short, user-facing What's New for a version from this repository's changes since the last release, in the style of the app's past notes, for every locale the app has (or the ones the user names), and save it to the version's release draft in SwiftSales.

Start with the SwiftSales tool `release_context`. From there, follow the tools: each result's `nextStep` and each tool's description say what comes next. When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.

If no SwiftSales tool is available in this session, even after searching for it, tell the user that SwiftSales works in Claude Code on a Mac with SwiftSales for Mac in Applications; without the app, they can get it from the App Store (https://apps.apple.com/app/swiftsales-app-sales-tracker/id6825301543), open it, turn on Settings › Agent Access, then start a new session there. Then stop.

## Inputs

- `app`: App key or exact name.
- `version`: Version, for example 1.3.
- `locales` (optional): Comma-separated locales; default: every locale the app has.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.
