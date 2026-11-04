# SwiftSales for Claude Code

[简体中文](README.zh-Hans.md)

Ask Claude Code about your App Store sales and reviews, and let it prepare your next release. The plugin connects
Claude Code to [SwiftSales](https://swiftsales.gitswift.com) on your Mac: your agent reads your sales, subscriptions
and customer reviews, drafts What's New, and asks you before anything is submitted or released.

## What you need

- A Mac with SwiftSales installed in Applications.
- Agent Access turned on in SwiftSales › Settings › Agent Access. Agent Access is part of Lifetime Premium and the
  7-day free trial.

## Install

```sh
claude plugin marketplace add GitSwiftHQ/swiftsales-agent
claude plugin install swiftsales@swiftsales-agent
```

The first time Claude Code connects, SwiftSales asks you to allow it. You choose its access level, from Read Only to
Submit, and which apps it can see.

Using auto mode? Allow SwiftSales in your Claude Code settings (`~/.claude/settings.json`), or auto mode turns its
calls down:

```json
{ "permissions": { "allow": ["mcp__plugin_swiftsales_swiftsales"] } }
```

Without the plugin, the rule is `mcp__swiftsales`. Submitting and releasing still wait for your approval in SwiftSales.

If SwiftSales is somewhere other than Applications, use the command under Settings › Agent Access › Connect ›
Claude Code › Without Plugin instead.

## Updating

Claude Code updates plugins from other marketplaces only when you turn it on. To get new versions automatically, open
`/plugin` › Marketplaces › swiftsales-agent and choose Enable auto-update.

To update now, run:

```sh
claude plugin update swiftsales@swiftsales-agent
```

or choose Update now under `/plugin` › Installed. A session that is already open picks up the new version after
`/reload-plugins`.

## What you can ask

- "How is Tallytide doing since the last release?"
- "Which countries brought the most proceeds this month?"
- "Summarise this week's one-star reviews."
- "Write What's New for 1.4 from the commits since 1.3, in every language the app has."
- "Prepare 1.4 for review."
- "Ship 1.4: build it, upload it and give it to the Beta group."

The plugin adds five skills you can also run directly:

| Skill | What it does |
| --- | --- |
| `/swiftsales:since-release` | Sales and reviews since an app's last release |
| `/swiftsales:whats-new` | What's New for a version, for every language the app has |
| `/swiftsales:ship` | A build of this repository's app, from archive to upload to release |
| `/swiftsales:release` | A release from draft to submission |
| `/swiftsales:create-iap` | An in-app purchase from draft to review |

## Ship a build

`/swiftsales:ship` takes the app in the repository you're working in all the way to App Store Connect:

1. Your agent reads the scheme, team, signing and version numbers from the project, raises the build number, and asks
   you when something isn't clear. It doesn't change your team, signing or certificates.
2. It archives and exports the build (`xcodebuild -exportArchive`, method `app-store-connect`) into your build folder.
3. SwiftSales uploads the `.ipa` or `.pkg` from your Mac. The first time, your agent asks where builds should live
   (for example `~/Builds/<app>`) and SwiftSales asks you to choose that folder: pick the folder itself, not the
   version folder inside it. Later builds in it upload without asking. Keep SwiftSales open while it uploads.
4. Apple processes the build, usually in a few minutes. Your agent checks on it, then can give it to your TestFlight
   groups.
5. Your agent selects the build for the version and goes on like `/swiftsales:release`: What's New, App Information,
   readiness, and submission, which waits for your approval.

You can change the build folder in SwiftSales › Settings › Agent Access › Releases › Build Folder. Every upload is
listed in Settings › Agent Access › Activity.

## Your approval, your data

- Submitting for review and releasing always wait for your approval in SwiftSales on your Mac.
- Your sales data and App Store Connect keys stay in SwiftSales. The plugin only tells Claude Code where SwiftSales
  is; nothing goes through a server of ours.
- SwiftSales hands review text to your agent marked as customer text to summarise.
- Every call your agent makes is listed in Settings › Agent Access › Activity.

## Other agents

Codex, Cursor, Claude Desktop and Xcode connect from Settings › Agent Access › Connect in SwiftSales. Each has its
own button there.

## License

MIT. See [LICENSE](LICENSE).
