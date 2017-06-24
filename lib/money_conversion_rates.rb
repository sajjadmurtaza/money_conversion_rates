require "money_conversion_rates/version"

module MoneyConversionRates

  class Money

    attr_accessor :amount , :currency

    def initialize(amount, currency)
      raise InvalidAmountError unless amount.is_a?(Numeric)
      raise InvalidCurrencyError unless currency.is_a(String)

      @amount = amount
      @currency = currency
    end

    def inspect
      "#{'%.2f' % amount} #{currency}"
    end

  end

end
