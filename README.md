# MoneyConversionRates


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money_conversion_rates', '~> 1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money_conversion_rates

## Usage

```ruby

MoneyConversionRates::Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})


fifty_eur = MoneyConversionRates::Money.new(50, 'EUR')


fifty_eur.amount   # => 50
fifty_eur.currency # => "EUR"
fifty_eur.inspect  # => "50.00 EUR"

# Convert to a different currency (should return a Money
# instance, not a String):

fifty_eur.convert_to('USD') # => 55.50 USD

# Perform operations in different currencies:

twenty_dollars = MoneyConversionRates::Money.new(20, 'USD')


# Comparisons (also in different currencies):

twenty_dollars == MoneyConversionRates::Money.new(20, 'USD') # => true
twenty_dollars == MoneyConversionRates::Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true

twenty_dollars > MoneyConversionRates::Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/money_conversion_rates.
