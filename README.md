# README

## 📋 The Challenge

Provide a Ruby or Ruby on Rails based solution to the following product feature requirement. Feel free to use your usual IDE, and any gems and online resources (within reason) you would usually use in a workplace.

In NZ, individuals who earn more income pay higher tax rates. We need to be able to provide our leads and support teams a tool that gives a more accurate tax estimate than the current calculator.

Here are the 2025 NZ income tax rates for individuals from IRD:

| For each dollar of income | Tax rate |
| ------------------------- | -------- |
| Up to $15,600             | 10.5%    |
| $15,601 - $53,500         | 17.5%    |
| $53,501 - $78,100         | 30%      |
| $78,101 - $180,000        | 33%      |
| $180,001 and over         | 39%      |

## 🧪 Test cases

Please use the following table to validate that your tax calculator is working correctly for different incomes

| Income   | Tax to pay |
| -------- | ---------- |
| $10,000  | $1,050.00  |
| $35,000  | $5,033.00  |
| $100,000 | $22,877.50 |
| $220,000 | $64,877.50 |

## ⏰ Timeframe

Please limit yourself to around 1 hour to complete the assessment.

## To run

Open a rails console

```ruby
rails console
```

then call

```ruby
Services::TaxCalculator.call(income: "$10,000")
=> "$1,050.00"
```

or save to call on later

```ruby
calculator = Services::TaxCalculator.new(income: "$10,000")
=> #<Services::TaxCalculator:0x00000001264117d0 @income_in_cents=1000000, @total_income_tax=0>

calculator.call
=> "$1,050.00"

calculator
=> #<Services::TaxCalculator:0x00000001264117d0 @income_in_cents=1000000, @total_income_tax="$1,050.00">
```
