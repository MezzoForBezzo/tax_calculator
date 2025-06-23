# frozen_string_literal: true

module Services
  class TaxCalculator
    def self.call(income:, in_cents: false)
      new(income:, in_cents: in_cents).call
    end

    def initialize(income:, in_cents: false)
      @income_in_cents = in_cents ? income.to_d : Monetize.parse(income).cents
      @total_income_tax = 0
    end

    def call
      total_income_tax = Util::TaxBrackets::NZ_TAX_BRACKETS.map do |tax_bracket|
        unless tax_bracket.range_in_cents.begin > income_in_cents
          income_within_bracket(tax_bracket.range_in_cents).size * tax_bracket.tax_rate
        end
      end.compact.sum

      @total_income_tax = Money.from_cents(total_income_tax).format
    end

    private

    attr_accessor :income_in_cents, :total_income_tax

    def income_within_bracket(bracket_in_cents)
      bracket_in_cents.begin..([ income_in_cents, bracket_in_cents.end ].min)
    end
  end
end
