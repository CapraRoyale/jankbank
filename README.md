# Jankbank
A parser for your janky bank statements

## How to use
``` ruby
line = "  09/12                   24HOUR FITNESS USA,INC 800-432-6348 CA                                                                    78.91"
JankbankParser.new(line).parse
# => #<struct Transaction date="09/12", description="24HOUR FITNESS USA,INC 800-432-6348 CA", amount="78.91">
```

## How to run the tests
```
make test
```

## Why does this exist
because many banks still have janky technology that stores your transaction data in a string like 

```
   10/10        FRED MEYER PORTLAND OR          54.31    
```

I want to extract it and put it somewhere useful, like a database or a spreadsheet, but all I have is a bunch of pdfs that are formatted like that above.

## Disclaimer
There is no guarantee this will work for your data.

I wrote this for my own transaction data, I use a Chase credit card with Amazon reward points for all my discretionary spending and then pay off the bill before any interest accrues. Chase puts all this data into PDF statements, which are.... janky.

If this doesn't work for you, feel free to file an issue with some example data so we can make this more general-purpose. 
