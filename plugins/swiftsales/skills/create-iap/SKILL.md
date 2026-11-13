---
name: create-iap
description: "Create an in-app purchase in App Store Connect with SwiftSales and submit it for review. Use when the user wants to create an in-app purchase for one of their apps and send it to App Store review."
---

# Create an in-app purchase

Create a consumable, non-consumable or non-renewing subscription in-app purchase: a draft in SwiftSales, written to App Store Connect, then submitted for review. Creating the product id waits for the user's approval in SwiftSales; they choose the review screenshot when they approve the submission.

Start with the SwiftSales tool `list_iaps`. From there, follow the tools: each result's `nextStep` and each tool's description say what comes next. When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.

## Inputs

- `app`: App key or exact name.
- `productId`: Product id, for example com.example.app.pro.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.
