# SwiftSales Claude Code 插件

[English](README.md)

在 Claude Code 里问你的 App Store 销售和评论，并让它为你准备下一个版本。这个插件把 Claude Code 连接到你 Mac 上的
[SwiftSales](https://swiftsales.gitswift.com)：agent 可以读取销售、订阅和用户评论，撰写“新功能”，提审和发布前都会先问你。

## 准备

- 一台 Mac，SwiftSales 安装在“应用程序”文件夹中。
- 在 SwiftSales › 设置 › Agent 接入 中打开 Agent 接入。Agent 接入包含在永久高级版和 7 天免费试用中。

## 安装

```sh
claude plugin marketplace add GitSwiftHQ/swiftsales-agent
claude plugin install swiftsales@swiftsales-agent
```

Claude Code 第一次连接时，SwiftSales 会请你允许，并由你选择访问级别（从只读到提审）以及它能看到哪些 App。

在用自动模式？请在 Claude Code 的设置（`~/.claude/settings.json`）里允许 SwiftSales，否则自动模式会拒绝它的调用：

```json
{ "permissions": { "allow": ["mcp__plugin_swiftsales_swiftsales"] } }
```

不用插件时，规则是 `mcp__swiftsales`。提审和发布仍然要你在 SwiftSales 里批准。

如果 SwiftSales 不在“应用程序”文件夹中，请改用 设置 › Agent 接入 › 连接 › Claude Code › 不用插件 里的命令。

## 更新

来自其他插件市场的插件，Claude Code 只在你打开自动更新后才会自动更新。想自动收到新版本，请打开
`/plugin` › Marketplaces › swiftsales-agent，选择 Enable auto-update。

想现在就更新，运行：

```sh
claude plugin update swiftsales@swiftsales-agent
```

或在 `/plugin` › Installed 里选择 Update now。已经打开的会话运行 `/reload-plugins` 后用上新版本。

## 可以这样问

- “Tallytide 上次发布以来表现怎么样？”
- “这个月哪些国家的收入最多？”
- “总结一下这周的一星评论。”
- “根据 1.3 以来的提交，用这个 App 的所有语言写 1.4 的新功能。”
- “准备好 1.4 提审。”
- “发布 1.4：构建、上传，再发给 Beta 测试组。”

插件还带有五个技能，也可以直接运行：

| 技能 | 用途 |
| --- | --- |
| `/swiftsales:since-release` | 某个 App 上次发布以来的销售和评论 |
| `/swiftsales:whats-new` | 为一个版本撰写所有语言的新功能 |
| `/swiftsales:ship` | 把这个仓库里的 App 归档、上传，并选作发布用的构建 |
| `/swiftsales:release` | 从草稿到提审，完成一次发布 |
| `/swiftsales:create-iap` | 从草稿到提审，完成一个内购项目 |

## 发布一个构建

`/swiftsales:ship` 把你正在开发的仓库里的 App 一路送到 App Store Connect：

1. agent 从项目里读取 scheme、团队、签名和版本号，调高构建号；有不清楚的地方会先问你。它不会改动你的团队、签名或证书。
2. 它归档并导出构建（`xcodebuild -exportArchive`，方式 `app-store-connect`），放进你的构建文件夹。
3. SwiftSales 从你的 Mac 上传 `.ipa` 或 `.pkg`。第一次上传时，agent 会问你构建放在哪里（例如 `~/Builds/<App>`），SwiftSales 会请你选择这个文件夹：选它本身，而不是里面的版本文件夹。之后放在里面的构建上传时不用再选。上传期间请保持 SwiftSales 打开。
4. Apple 处理构建，通常几分钟。agent 会查看进度，处理完成后可以把构建发给你的 TestFlight 测试组。
5. agent 为这个版本选好构建，然后像 `/swiftsales:release` 一样继续：新功能、App 信息、就绪检查和提审，提审要等你批准。

构建文件夹可以在 SwiftSales › 设置 › Agent 接入 › 发布 › 构建文件夹 中更改。每一次上传都列在 设置 › Agent 接入 › 活动 中。

## 由你批准，数据留在你手里

- 提审和发布总是等你在 Mac 上的 SwiftSales 中批准。
- 销售数据和 App Store Connect 密钥都留在 SwiftSales 中。插件只告诉 Claude Code SwiftSales 在哪里，不经过我们的任何服务器。
- SwiftSales 把评论内容交给 agent 时，会标明这是用户写的文字，供它总结。
- agent 的每一次调用都列在 设置 › Agent 接入 › 活动 中。

## 其他 agent

Codex、Cursor、Claude 桌面版和 Xcode 在 SwiftSales 的 设置 › Agent 接入 › 连接 中连接，每个都有自己的按钮。

## 许可

MIT，见 [LICENSE](LICENSE)。
