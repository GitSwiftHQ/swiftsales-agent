---
name: create-iap
description: "Create an in-app purchase in App Store Connect with SwiftSales and submit it for review. Use when the user wants to create an in-app purchase for one of their apps and send it to App Store review."
---

# Create an in-app purchase

Uses the SwiftSales tools on this Mac: `list_iaps`, `iap_price_points`, `prepare_iap`, `submit_iap`, `apply_iap`, `release_status`, `approval_status`.

## Inputs

- `app`: App key or exact name.
- `productId`: Product id, for example com.example.app.pro.

Take them from the request ($ARGUMENTS). When the app is unclear, call `list_apps` and use its app key; ask the user for anything else that is missing.

## Steps

Create the in-app purchase <productId> for <app> with the SwiftSales tools.
1. Ask the user for the type (consumable, non-consumable or non-renewing subscription; auto-renewable subscriptions are done in App Store Connect), the price in the base territory (or free), the locales with a display name (≤ 30 characters) and description (≤ 45), and whether Family Sharing is on (it can't be turned off later).
2. Call list_iaps for <app>; use iap_price_points to check the price exists.
3. Call prepare_iap. The user chooses the review screenshot in SwiftSales, on submit_iap's approval sheet.
4. Call apply_iap; creating the product id waits for the user's approval. Tell the user about `needsYou`.
5. Call release_status for <app> and take the version and platform from it (ask the user when more than one fits; never guess a version). Call submit_iap, passing `withVersion` when it is the app's first in-app purchase of its type, and `platform` when the app has versions on more than one platform.
When a tool returns `pending`, stop and ask the user to approve in SwiftSales on their Mac; don't call approval_status in a loop.
