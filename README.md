# SwiftSales for Claude Code

[简体中文](README.zh-Hans.md)

Ask Claude Code about your App Store sales and reviews, and let it prepare your next release. The plugin connects
Claude Code to [SwiftSales](https://swiftsales.gitswift.com) on your Mac: your agent reads your sales, subscriptions,
transactions and customer reviews, drafts What's New, and asks you before anything is submitted or released.

The plugin works in Claude Code on a Mac.

## First, get SwiftSales

1. [Get SwiftSales on the App Store](https://apps.apple.com/app/swiftsales-app-sales-tracker/id6825301543) on your
   Mac and keep it in Applications. It's a free download; you need version 1.0.1 or later.
2. Open SwiftSales and connect App Store Connect.
3. Turn on Agent Access in SwiftSales › Settings › Agent Access. Agent Access is part of Lifetime Premium and the
   7-day free trial.

## Install

```sh
claude plugin marketplace add GitSwiftHQ/swiftsales-agent
claude plugin install swiftsales@swiftsales-agent
```

The first time Claude Code connects, SwiftSales asks you to allow it. You choose its access level, from Read Only to
Submit, and which apps it can see. Start a new session after installing to use SwiftSales right away.

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
- "Any purchases or refunds for Tallytide today?"
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

## Try it with sample data

SwiftSales has a demo with sample apps, sales and reviews. It needs no App Store Connect key.

1. Get SwiftSales from the App Store, open it and choose Try the Demo. Screens with sample data are labelled Demo Data.
2. Agent Access needs Lifetime Premium or the free trial: choose Start 7-Day Free Trial in Settings › Purchase.
3. Turn on Agent Access in Settings › Agent Access, install the plugin and start a new Claude Code session.
4. Ask "How is Tallytide doing since the last release?" or "Which countries brought the most proceeds this month?"
   Results from the demo carry `"demo": true`.

## What the plugin runs

- `.mcp.json` runs `sh ${CLAUDE_PLUGIN_ROOT}/scripts/swiftsales-agent.sh`. This short script starts the SwiftSales
  agent helper inside the app (`/Applications/SwiftSales.app/Contents/Helpers/SwiftSalesAgent.app`), which connects
  Claude Code to SwiftSales on your Mac. If SwiftSales isn't in Applications, the script says where to get it and
  stops.
- Five skills: `since-release`, `whats-new`, `ship`, `release` and `create-iap`.
- The plugin itself fetches nothing, sends nothing, installs nothing and stores nothing.

## Your approval, your data

- Submitting for review and releasing always wait for your approval in SwiftSales on your Mac.
- Your App Store Connect keys stay in SwiftSales. SwiftSales reads your data from App Store Connect with your own key;
  none of it goes through a server of ours.
- What your agent asks for goes to your Claude Code session: sales figures, review text and reviewer nicknames.
- Some tools read and, when you ask, change personal data in your App Store Connect team: names and email addresses of
  team members and testers, TestFlight feedback (tester names, comments, crash logs), the App Review contact (name,
  email, phone) and registered devices (names, UDIDs). Changes happen only within the access level you gave the agent
  in SwiftSales.
- This data moves only between your Mac, Apple and your agent. The plugin and GitSwift store none of it, and none of
  it goes through a server of ours.
- SwiftSales hands review text to your agent marked as customer text to summarise.
- Transactions reach your agent without customer identifiers; transaction IDs show only their last 4 digits.
- Every call your agent makes is listed in Settings › Agent Access › Activity.

## Troubleshooting

- **No SwiftSales tools, or `/mcp` shows `plugin:swiftsales:swiftsales` as failed:** check that SwiftSales for Mac is in Applications, then
  start a new session. If it's somewhere else, use the command under Settings › Agent Access › Connect › Claude Code ›
  Without Plugin.
- **Calls say Agent Access is off or needs Lifetime Premium:** turn on Agent Access in Settings › Agent Access, or
  start the free trial in Settings › Purchase.
- **Calls wait for permission:** SwiftSales asks you to allow Claude Code the first time it connects. Choose Allow
  on your Mac.
- **Calls say SwiftSales needs reconnecting:** run `/mcp`, choose `plugin:swiftsales:swiftsales`, then Reconnect.
- **Auto mode turns calls down:** add the allow rule under Install.

## Other agents

Codex, Cursor and Xcode connect from Settings › Agent Access › Connect in SwiftSales. Each has its own button there.

## Support

Email [swiftsales@gitswift.com](mailto:swiftsales@gitswift.com) or visit
[swiftsales.gitswift.com/support](https://swiftsales.gitswift.com/support).

## Privacy

[Privacy Policy](https://swiftsales.gitswift.com/privacy)

## License

MIT. See [LICENSE](LICENSE).
