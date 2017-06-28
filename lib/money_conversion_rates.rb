require "money_conversion_rates/version"

module MoneyConversionRates

  class Money
    include MoneyConversionRates::Money::Arithmetics

    attr_accessor :amount , :currency

    def initialize(amount, currency)
      raise InvalidAmountError   unless amount.is_a?(Numeric)
      raise InvalidCurrencyError unless currency.is_a?(String)

      @amount = amount
      @currency = currency
    end

    def inspect
      "#{'%.2f' % amount} #{currency}"
    end

    def self.conversion_rates(currency, rates)
      raise InvalidRatesAHashError   unless rates.is_a?(Hash)
      raise InvalidRatesNumbersError unless rates.values.all? {|v| v.is_a?(Numeric) }

      @rates[currency.to_sym] = rates
    end

    def convert_to(other_currency)
      if self.conversion_rates
        other_currency_conversion_rate = self.conversion_rates[other_currency]
      else
        base_currency_conversion_rates = self.class.get_conversion_rates[other_currency.to_sym]

        other_currency_conversion_rate = base_currency_conversion_rates ?
            1/base_currency_conversion_rates[self.currency].to_f :
            nil
      end

      raise NoConvertionRateDefinedError unless other_currency_conversion_rate

      other_currency_amount = (other_currency_conversion_rate * amount).round(2)

      return self.class.new(other_currency_amount, other_currency)
    end


    protected

      def conversion_rates
        self.class.get_conversion_rates[currency.to_sym]
      end

    private

      def self.get_conversion_rates
        @conversion_rates
      end


  end

end
