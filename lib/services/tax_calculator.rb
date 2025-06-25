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
      @total_income_tax = Money.from_cents(total_income_tax_calculator).format
    end

    private

    attr_accessor :income_in_cents, :total_income_tax

    def total_income_tax_calculator
      id = Util::Nz::TaxBrackets.find_id(income_in_cents)

      Util::Nz::TaxBrackets::TAX_BRACKETS.reduce(0) do |summed_value, tax_bracket|
        if tax_bracket.tax_bracket_id < id
          summed_value += (tax_bracket.range_in_cents.size * tax_bracket.tax_rate)
        elsif tax_bracket.tax_bracket_id == id
          summed_value += (income_within_bracket(tax_bracket.range_in_cents).size * tax_bracket.tax_rate)
        end

        summed_value
      end
    end

    def income_within_bracket(bracket_in_cents)
      bracket_in_cents.begin..income_in_cents
    end
  end
end
