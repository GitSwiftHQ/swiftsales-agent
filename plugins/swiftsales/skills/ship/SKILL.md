---
name: ship
description: "Archive and export the app in this repository, upload the build with SwiftSales, wait for processing, then prepare the release. Use when the user wants to build, upload or ship a new build or version of the app in this repository to App Store Connect, TestFlight or the App Store."
---

# Ship a build

Uses the SwiftSales tools on this Mac: `release_status`, `list_builds`, `build_folder`, `upload_build`, `build_upload_status`, `distribute_build`, `prepare_release`, `release_context`, `set_whats_new`, `check_readiness`, `app_info`, `set_app_info`, `set_categories`, `set_age_rating`, `apply_release`, `submit_for_review`, `apply_product_page`, `submit_product_page`, `upload_media`, `apply_app_event`, `submit_app_event`, `apply_nomination`, `submit_nomination`, `xcode_cloud_status`, `start_cloud_build`, `approval_status`.

## Inputs

- `app`: App key or exact name.
- `version` (optional): Version to ship, for example 1.4; default: the project's MARKETING_VERSION.
- `groups` (optional): TestFlight groups to give the build to before submission, comma-separated; default: none.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.

## Steps

Ship <app> with the SwiftSales tools: you archive and export the build in this repository, SwiftSales uploads it from this Mac, then the release is prepared. Version: <version>. TestFlight groups: <groups>.
1. Read the project, never guess: `xcodebuild -list` for the scheme, then `xcodebuild -showBuildSettings -scheme <scheme> -configuration Release` for DEVELOPMENT_TEAM, CODE_SIGN_STYLE, PRODUCT_BUNDLE_IDENTIFIER, MARKETING_VERSION and CURRENT_PROJECT_VERSION (add `-workspace` or `-project` when the repository has more than one). Ask the user when the scheme, the team or the signing is unclear. Never change the team, the signing style, certificates or profiles on your own.
2. Call release_status for <app>: ship the version in preparation, or a new one higher than the live version. Call list_builds for <app> (with `platform` when the app is on more than one): the build number (CFBundleVersion) must be higher than every build of that version. Raising CURRENT_PROJECT_VERSION (or MARKETING_VERSION for a new version) is your job; tell the user the numbers you chose. When a processed build of the version is already there and the user only wants to submit it, follow the release skill instead.
3. Call build_folder. `ok`: export into `<path>/<version>-<number>`. `none` or `unavailable`: ask the user where builds should live, suggesting a folder outside this repository such as `~/Builds/<app name>`, and export into `<that folder>/<version>-<number>`. upload_build then shows a card in SwiftSales: tell the user to choose that parent folder on it (the panel opens there), so later builds in it upload without the card.
4. Archive, one archive per platform: `xcodebuild archive -scheme <scheme> -configuration Release -destination 'generic/platform=iOS' -archivePath build/<scheme>-<version>-<number>.xcarchive` (`generic/platform=macOS`, `tvOS` or `visionOS` for the other platforms). Add `-allowProvisioningUpdates` to the archive and the export only when CODE_SIGN_STYLE is Automatic.
5. Export with an options plist outside the build folder, for example `build/ExportOptions.plist`, with the team and signing style from step 1 (`manual` adds `provisioningProfiles`: bundle id → profile name, from the project or the user):
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>method</key><string>app-store-connect</string>
       <key>destination</key><string>export</string>
       <key>teamID</key><string>ABCDE12345</string>
       <key>signingStyle</key><string>automatic</string>
       <key>manageAppVersionAndBuildNumber</key><false/>
   </dict>
   </plist>
   ```
   Then `xcodebuild -exportArchive -archivePath <archive> -exportOptionsPlist build/ExportOptions.plist -exportPath <folder>/<version>-<number>`. iOS, tvOS and visionOS give an `.ipa`, macOS a `.pkg`. Take the version and build number from the archive: `/usr/libexec/PlistBuddy -c 'Print :ApplicationProperties:CFBundleVersion' <archive>/Info.plist` (and CFBundleShortVersionString).
6. Call upload_build with <app>, the exported file's absolute path, the version and the build number (a `.pkg` is a Mac build; for an `.ipa`, pass `platform` when the app is on more than one of iOS, tvOS and visionOS). It answers within seconds with an `uploadID`; SwiftSales uploads the file and must stay open.
7. Call build_upload_status with the `uploadID` every 30–60 seconds: `uploading`, then `processing` (Apple usually takes a few minutes), then `complete` with the processed `build`.
8. TestFlight, when groups are given: call distribute_build with the build "<version> (<number>)" and those groups. An external group sends the build to TestFlight App Review and needs the user's approval; below the Submit level it answers `policy_denied`: tell the user external groups need the Submit level in SwiftSales.
9. Call prepare_release for <app> with the version, the build "<version> (<number>)" and the release type the user wants. Then go on as in the release skill: release_context for the locales, set_whats_new for every locale, check_readiness and the tool each blocking item needs (app_info, set_app_info, set_categories, set_age_rating), apply_release, submit_for_review.
10. Only when the user asks for it with this release: a custom product page (apply_product_page, then submit_product_page), an in-app event (upload_media with `for` eventCard / eventDetails, apply_app_event, then submit_app_event) or a featuring nomination (apply_nomination, then submit_nomination). Each goes to Apple on its own and waits for the user's approval in SwiftSales.
Xcode Cloud is optional and never the default: build locally as above. Only when the user asks for a cloud build, call xcode_cloud_status for <app> to find the workflow, then start_cloud_build with the workflow and the branch, tag or `#<pull request>`. It always waits for the user's approval in SwiftSales (the build uses the team's compute hours); on `pending`, stop and ask them. Afterwards follow the run with xcode_cloud_status and its `run` id; a workflow whose archive is for the App Store delivers the build to App Store Connect itself: once list_builds shows it processed, go on at step 8.
When a tool fails, read its `code` and `nextStep`:
- `build_folder_required`, or `file_not_in_build_folder` from upload_build: SwiftSales shows the user a card to choose the build folder. Stop and ask them to choose the parent folder from step 3 in SwiftSales on their Mac; when they say they did, call approval_status with the `approvalID` once. When its `result` has an `uploadID`, the upload has started: go on at step 7 with that `uploadID`. Later builds go into the folder build_folder returns.
- approval_status `failed` with `result.reason` `folderNotChosen` (the folder the user chose doesn't hold the file): call build_folder, export the build into that folder, then call upload_build again.
- `build_exists`: App Store Connect has this build number. Raise it above `previousBuildNumber`, archive and export again, then call upload_build.
- state `failed` (`upload_failed`): Apple refused the build. Show the user `errors` as they are, fix the cause (a version that has to be higher than the approved one: raise MARKETING_VERSION), raise the build number and ship again.
- `upload_expired` or `file_changed`: call upload_build again with the same version and build number.
- `upload_in_progress`: call build_upload_status with the `uploadID` in the error.
- `file_type_unsupported` or `platform_file_mismatch`: upload the exported `.ipa` or `.pkg` with its platform.
- xcodebuild fails on signing, a profile or a certificate: show the user the error and ask; don't work around it.
When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.
