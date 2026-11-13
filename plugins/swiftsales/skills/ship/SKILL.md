---
name: ship
description: "Archive and export the app in this repository, upload the build with SwiftSales, wait for processing, then prepare the release. Use when the user wants to build, upload or ship a new build or version of the app in this repository to App Store Connect, TestFlight or the App Store."
---

# Ship a build

Ship the app in this repository: you archive and export the build here, SwiftSales uploads it from this Mac and waits for Apple's processing, then the build goes to the TestFlight groups the user names and into a release draft that is submitted for review. Xcode Cloud only when the user asks for it.

Start with the SwiftSales tool `build_folder`. From there, follow the tools: each result's `nextStep` and each tool's description say what comes next. When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.

## Inputs

- `app`: App key or exact name.
- `version` (optional): Version to ship, for example 1.4; default: the project's MARKETING_VERSION.
- `groups` (optional): TestFlight groups to give the build to before submission, comma-separated; default: none.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.
