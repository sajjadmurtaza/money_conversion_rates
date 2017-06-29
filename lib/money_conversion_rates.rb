require "money_conversion_rates/version"

module MoneyConversionRates

  class Money

    attr_accessor :amount , :currency
    @rates = {}

    def initialize(amount, currency)
      raise InvalidAmountError   unless amount.is_a?(Numeric)
      raise InvalidCurrencyError unless currency.is_a?(String)

      @amount = amount
      @currency = currency
    end

    def inspect
      "#{'%.2f' % amount}, #{currency}"
    end

    def self.conversion_rates(currency, rates)
      raise InvalidRatesAHashError   unless rates.is_a?(Hash)
      raise InvalidRatesNumbersError unless rates.values.all? {|v| v.is_a?(Numeric) }

      p "===================================="
      p "Rates: #{rates}"
      p "Currency: #{currency}"
      p "===================================="


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

    [:+, :-].each do |operator|
      define_method(operator) do |other|
        other = other.convert_to(currency) if currency != other.currency && other.amount != 0

        return self.class.new(amount.send(operator, other.amount).round(2), currency)
      end
    end

    [:==, :>, :<].each do |operator|
      define_method(operator) do |other|

        other = other.convert_to(currency) if currency != other.currency && other.amount != 0
        return amount.send(operator, other.amount)
      end
    end

    def /(number)

      return self.class.new((amount / number).round(2), currency)
    end

    def *(number)

      return self.class.new((amount * number).round(2), currency)
    end


    protected

      def conversion_rates
        self.class.get_conversion_rates[currency.to_sym]
      end

    private

      def self.get_conversion_rates
        @rates
      end


  end

end
