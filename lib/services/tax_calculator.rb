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
      income_as_range_in_cents = 0..income_in_cents

      total_income_tax = Util::TaxBrackets::NZ_TAX_BRACKETS.map do |tax_bracket|
        taxable_range_in_cents = tax_bracket.range_in_cents

        # Skip if the income is less than the start of the bracket
        unless taxable_range_in_cents.begin > income_in_cents

          # Use the total amount of the bracket in cents
          #
          # OR
          #
          # the amount of income within the current bracket
          taxable_amount_in_bracket =
            income_as_range_in_cents.cover?(taxable_range_in_cents) ? taxable_range_in_cents : (taxable_range_in_cents.begin..income_in_cents)

          taxable_amount_in_bracket.size * tax_bracket.tax_rate
        end
      end.compact.sum

      @total_income_tax = Money.from_cents(total_income_tax).format
    end

    private

    attr_accessor :income_in_cents, :total_income_tax
  end
end
