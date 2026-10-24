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

## What you can ask

- "How is Tallytide doing since the last release?"
- "Which countries brought the most proceeds this month?"
- "Summarise this week's one-star reviews."
- "Write What's New for 1.4 from the commits since 1.3, in every language the app has."
- "Prepare 1.4 for review."

The plugin adds four skills you can also run directly:

| Skill | What it does |
| --- | --- |
| `/swiftsales:since-release` | Sales and reviews since an app's last release |
| `/swiftsales:whats-new` | What's New for a version, for every language the app has |
| `/swiftsales:release` | A release from draft to submission |
| `/swiftsales:create-iap` | An in-app purchase from draft to review |

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
