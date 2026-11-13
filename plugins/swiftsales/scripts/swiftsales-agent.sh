#!/bin/sh
# SwiftSales plugin launcher: starts the SwiftSales agent helper inside SwiftSales for Mac, the MCP server this
# plugin uses, on standard input and output. The plugin itself fetches nothing and sends nothing.
if [ -x '/Applications/SwiftSales.app/Contents/Helpers/SwiftSalesAgent.app/Contents/MacOS/SwiftSalesAgent' ]; then
    exec '/Applications/SwiftSales.app/Contents/Helpers/SwiftSalesAgent.app/Contents/MacOS/SwiftSalesAgent'
fi
echo "SwiftSales: this plugin runs SwiftSales for Mac, which isn't in Applications. Get it from the App Store (https://apps.apple.com/app/swiftsales-app-sales-tracker/id6825301543), open it, turn on Settings › Agent Access, then start a new session." >&2
exit 1
