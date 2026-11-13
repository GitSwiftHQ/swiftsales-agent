---
name: release
description: "Walk through releasing a version with SwiftSales: status, draft, What's New, readiness, submission. Use when the user wants to release or submit a new version of one of their apps whose build is already uploaded."
---

# Release a version

Release a version whose build is already uploaded: select the build in a SwiftSales release draft, write What's New from this repository's changes for every locale, clear what blocks readiness, then write the draft to App Store Connect and submit it for review.

Start with the SwiftSales tool `release_status`. From there, follow the tools: each result's `nextStep` and each tool's description say what comes next. When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.

If no SwiftSales tool is available in this session, even after searching for it, tell the user that SwiftSales works in Claude Code on a Mac with SwiftSales for Mac in Applications; without the app, they can get it from the App Store (https://apps.apple.com/app/swiftsales-app-sales-tracker/id6825301543), open it, turn on Settings › Agent Access, then start a new session there. Then stop.

## Inputs

- `app`: App key or exact name.
- `version`: Version to release, for example 1.3.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.
