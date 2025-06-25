# frozen_string_literal: true

module Util
  module Nz
    class TaxBrackets
      # 2021 tax brackets
      TaxBracket = Struct.new(:tax_bracket_id, :range_in_cents, :tax_rate)

      INFINITY = BigDecimal("Infinity").freeze

      TAX_BRACKETS = [
        TaxBracket.new(tax_bracket_id: 1, range_in_cents:          0..15_600_00,  tax_rate: BigDecimal("0.105")).freeze,
        TaxBracket.new(tax_bracket_id: 2, range_in_cents:  15_600_01..53_500_00,  tax_rate: BigDecimal("0.175")).freeze,
        TaxBracket.new(tax_bracket_id: 3, range_in_cents:  53_500_01..78_100_00,  tax_rate: BigDecimal("0.30")).freeze,
        TaxBracket.new(tax_bracket_id: 4, range_in_cents:  78_100_01..180_000_00, tax_rate: BigDecimal("0.33")).freeze,
        TaxBracket.new(tax_bracket_id: 5, range_in_cents: 180_000_01..INFINITY,   tax_rate: BigDecimal("0.39")).freeze
      ].freeze

      def self.find_bracket(income_in_cents)
        TAX_BRACKETS.find { |bracket| bracket.range_in_cents.include?(income_in_cents) }
      end

      def self.find_id(income_in_cents)
        find_bracket(income_in_cents).tax_bracket_id
      end
    end
  end
end
