# SwiftSales Claude Code 插件

[English](README.md)

在 Claude Code 里问你的 App Store 销售和评论，并让它为你准备下一个版本。这个插件把 Claude Code 连接到你 Mac 上的
[SwiftSales](https://swiftsales.gitswift.com)：agent 可以读取销售、订阅、交易和用户评论，撰写“新功能”，提审和发布前都会先问你。

插件在 Mac 上的 Claude Code 里使用。

## 先装好 SwiftSales

1. 在 Mac 上[从 App Store 下载 SwiftSales](https://apps.apple.com/app/swiftsales-app-sales-tracker/id6825301543)，放在“应用程序”文件夹中。
   下载免费，需要 1.0.1 或更高版本。
2. 打开 SwiftSales，连接 App Store Connect。
3. 在 SwiftSales › 设置 › Agent 接入 中打开 Agent 接入。Agent 接入包含在永久高级版和 7 天免费试用中。

## 安装

```sh
claude plugin marketplace add GitSwiftHQ/swiftsales-agent
claude plugin install swiftsales@swiftsales-agent
```

Claude Code 第一次连接时，SwiftSales 会请你允许，并由你选择访问级别（从只读到提审）以及它能看到哪些 App。安装后新开一个
会话，就能马上使用 SwiftSales。

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
- “Tallytide 今天有新的购买或退款吗？”
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

## 用示例数据试用

SwiftSales 带有演示，里面有示例 App、销售和评论，不需要 App Store Connect 密钥。

1. 从 App Store 下载 SwiftSales，打开后选择“查看演示”。显示示例数据的页面都标有“演示数据”。
2. Agent 接入需要永久高级版或免费试用：在 设置 › 购买 中选择“开始 7 天免费试用”。
3. 在 设置 › Agent 接入 中打开 Agent 接入，安装插件，再新开一个 Claude Code 会话。
4. 问“Tallytide 上次发布以来表现怎么样？”或“这个月哪些国家的收入最多？”。演示中的结果都带有 `"demo": true`。

## 插件运行什么

- `.mcp.json` 运行 `sh ${CLAUDE_PLUGIN_ROOT}/scripts/swiftsales-agent.sh`。这个很短的脚本启动 App 里的 SwiftSales agent
  助手（`/Applications/SwiftSales.app/Contents/Helpers/SwiftSalesAgent.app`），由它把 Claude Code 连接到你 Mac 上的
  SwiftSales。如果 SwiftSales 不在“应用程序”文件夹中，脚本会说明去哪里下载，然后停止。
- 五个技能：`since-release`、`whats-new`、`ship`、`release` 和 `create-iap`。
- 插件本身不下载、不发送、不安装、也不保存任何内容。

## 由你批准，你的数据

- 提审和发布总是等你在 Mac 上的 SwiftSales 中批准。
- App Store Connect 密钥留在 SwiftSales 中。SwiftSales 用你自己的密钥从 App Store Connect 读取数据，这些数据都不经过我们的任何服务器。
- agent 请求的内容会交给你的 Claude Code 会话：销售数字、评论内容和评论者昵称。
- 有些工具会读取你的 App Store Connect 团队中的个人信息，并在你要求时修改它们：团队成员和测试员的姓名与邮箱、TestFlight 反馈
  （测试员姓名、反馈内容、崩溃日志）、App 审核联系人（姓名、邮箱、电话）以及已注册的设备（名称、UDID）。修改只在你在 SwiftSales
  中给 agent 的访问级别之内进行。
- 这些信息只在你的 Mac、Apple 和你的 agent 之间传递。插件和 GitSwift 都不保存，也不经过我们的任何服务器。
- SwiftSales 把评论内容交给 agent 时，会标明这是用户写的文字，供它总结。
- 交易交给 agent 时不含任何用户标识，交易号只保留后 4 位。
- agent 的每一次调用都列在 设置 › Agent 接入 › 活动 中。

## 排错

- **没有 SwiftSales 工具，或 `/mcp` 里 `plugin:swiftsales:swiftsales` 显示失败：** 确认 SwiftSales 在“应用程序”文件夹中，然后新开一个会话。
  如果它在别的位置，请改用 设置 › Agent 接入 › 连接 › Claude Code › 不用插件 里的命令。
- **调用提示 Agent 接入未打开或需要永久高级版：** 在 设置 › Agent 接入 中打开 Agent 接入，或在 设置 › 购买 中开始免费试用。
- **调用在等待允许：** Claude Code 第一次连接时，SwiftSales 会请你允许。在 Mac 上选择“允许”。
- **调用提示需要重新连接 SwiftSales：** 运行 `/mcp`，选择 `plugin:swiftsales:swiftsales`，然后选 Reconnect。
- **自动模式拒绝调用：** 按“安装”里的说明添加允许规则。

## 其他 agent

Codex、Cursor 和 Xcode 在 SwiftSales 的 设置 › Agent 接入 › 连接 中连接，每个都有自己的按钮。

## 支持

发邮件到 [swiftsales@gitswift.com](mailto:swiftsales@gitswift.com)，或访问
[swiftsales.gitswift.com/zh/support](https://swiftsales.gitswift.com/zh/support)。

## 隐私

[隐私政策](https://swiftsales.gitswift.com/zh/privacy)（[Privacy Policy](https://swiftsales.gitswift.com/privacy)）

## 许可

MIT，见 [LICENSE](LICENSE)。
