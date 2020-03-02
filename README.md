# CurrencyFormat
APEX Plugin providing live, as you type, formatting of currencies.

No longer worry about which grouping and decimal separtors your app will need. This plugin uses the browser language to determine the appropriate symbols and format accordingly.

Currencies codes that are supported are listed [here](https://www.currency-iso.org/en/home/tables/table-a1.html)

Javascript is also used to convert to number before submit for easy use when combining with SQL or PL/SQL functions.

## Download [here](https://github.com/CodeQuadrant/CurrencyFormat/blob/master/item_type_plugin_currencyformat.sql)

Demo - English

![Demo - English](demo.gif)

Demo - German

![Demo - German](demo_ger.gif)

### Instructions

1.  Download and install plugin
2.  Create currency cody select list or radio button with currency codes you wish to support
3.  Link the item you created in step 2 to the currencyFormat plugin item 
