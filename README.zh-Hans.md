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

如果 SwiftSales 不在“应用程序”文件夹中，请改用 设置 › Agent 接入 › 连接 › Claude Code › 不用插件 里的命令。

## 可以这样问

- “Tallytide 上次发布以来表现怎么样？”
- “这个月哪些国家的收入最多？”
- “总结一下这周的一星评论。”
- “根据 1.3 以来的提交，用这个 App 的所有语言写 1.4 的新功能。”
- “准备好 1.4 提审。”

插件还带有四个技能，也可以直接运行：

| 技能 | 用途 |
| --- | --- |
| `/swiftsales:since-release` | 某个 App 上次发布以来的销售和评论 |
| `/swiftsales:whats-new` | 为一个版本撰写所有语言的新功能 |
| `/swiftsales:release` | 从草稿到提审，完成一次发布 |
| `/swiftsales:create-iap` | 从草稿到提审，完成一个内购项目 |

## 由你批准，数据留在你手里

- 提审和发布总是等你在 Mac 上的 SwiftSales 中批准。
- 销售数据和 App Store Connect 密钥都留在 SwiftSales 中。插件只告诉 Claude Code SwiftSales 在哪里，不经过我们的任何服务器。
- SwiftSales 把评论内容交给 agent 时，会标明这是用户写的文字，供它总结。
- agent 的每一次调用都列在 设置 › Agent 接入 › 活动 中。

## 其他 agent

Codex、Cursor、Claude 桌面版和 Xcode 在 SwiftSales 的 设置 › Agent 接入 › 连接 中连接，每个都有自己的按钮。

## 许可

MIT，见 [LICENSE](LICENSE)。
