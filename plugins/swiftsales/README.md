# SwiftSales

Ask Claude about your App Store sales, subscriptions, transactions and customer reviews, and let it prepare your next
release. This plugin connects Claude Code to SwiftSales on your Mac, which keeps your App Store Connect keys and data.
Submitting for review and releasing always wait for your approval in SwiftSales. The plugin works in Claude Code on a
Mac.

## First, get SwiftSales

1. [Get SwiftSales on the App Store](https://apps.apple.com/app/swiftsales-app-sales-tracker/id6825301543) on your
   Mac and keep it in Applications. It's a free download; you need version 1.0.1 or later.
2. Open SwiftSales and connect App Store Connect.
3. Turn on Agent Access in SwiftSales › Settings › Agent Access. Agent Access is part of Lifetime Premium and the
   7-day free trial.

## What you can ask

- "How is Tallytide doing since the last release?"
- "Which countries brought the most proceeds this month?"
- "Summarise this week's one-star reviews."
- "Write What's New for 1.4 from the commits since 1.3, in every language the app has."
- "Prepare 1.4 for review."

## Try it with sample data

SwiftSales has a demo with sample apps, sales and reviews; it needs no App Store Connect key. Open SwiftSales and choose
Try the Demo, start the free trial in Settings › Purchase (Agent Access needs Lifetime Premium or the trial), turn on
Agent Access, then ask about Tallytide in a new Claude Code session. Results from the demo carry `"demo": true`.

## What the plugin runs

- `.mcp.json` runs `sh ${CLAUDE_PLUGIN_ROOT}/scripts/swiftsales-agent.sh`. This short script starts the SwiftSales
  agent helper inside the app (`/Applications/SwiftSales.app/Contents/Helpers/SwiftSalesAgent.app`). If SwiftSales
  isn't in Applications, it says where to get it and stops.
- Five skills: `since-release`, `whats-new`, `ship`, `release` and `create-iap`.
- The plugin itself fetches nothing, sends nothing, installs nothing and stores nothing.

## Your data

What your agent asks for goes to your Claude Code session: sales figures, review text and reviewer nicknames. Some
tools read and, when you ask, change personal data in your App Store Connect team: names and email addresses of team
members and testers, TestFlight feedback, the App Review contact (name, email, phone) and registered devices (names,
UDIDs), always within the access level you gave the agent in SwiftSales. This data moves only between your Mac, Apple
and your agent; the plugin and GitSwift store none of it, and none of it goes through a server of ours.

## Troubleshooting

- No SwiftSales tools, or `/mcp` shows `plugin:swiftsales:swiftsales` as failed: check that SwiftSales is in Applications, then start a new
  session.
- Calls say Agent Access is off or needs Lifetime Premium: turn on Agent Access in Settings › Agent Access, or start
  the free trial in Settings › Purchase.
- Calls wait for permission: choose Allow in SwiftSales on your Mac.

More in the [repository's README](https://github.com/GitSwiftHQ/swiftsales-agent#readme).

## Support

Email [swiftsales@gitswift.com](mailto:swiftsales@gitswift.com) or visit
[swiftsales.gitswift.com/support](https://swiftsales.gitswift.com/support).

## Privacy

[Privacy Policy](https://swiftsales.gitswift.com/privacy)
