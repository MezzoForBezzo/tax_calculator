# frozen_string_literal: true

module Util
  module Au
    class TaxBrackets
      # 2025-2026 tax brackets for AU
      TaxBracket = Struct.new(:tax_bracket_id, :range_in_cents, :tax_rate)

      INFINITY = BigDecimal("Infinity").freeze

      NZ_TAX_BRACKETS = [
        TaxBracket.new(tax_bracket_id: 1, range_in_cents:          0..18_200_00,  tax_rate: BigDecimal("0"), maximum_tax_amount: BigDecimal("0")).freeze,
        TaxBracket.new(tax_bracket_id: 2, range_in_cents:  18_200_01..45_000_00,  tax_rate: BigDecimal("0.16"), maximum_tax_amount: BigDecimal("4288_00")).freeze,
        TaxBracket.new(tax_bracket_id: 3, range_in_cents:  45_000_01..135_000_00,  tax_rate: BigDecimal("0.30"), maximum_tax_amount: BigDecimal("31_288_00")).freeze,
        TaxBracket.new(tax_bracket_id: 4, range_in_cents:  135_000_01..190_000_00, tax_rate: BigDecimal("0.37"), maximum_tax_amount: BigDecimal("51_638_00")).freeze,
        TaxBracket.new(tax_bracket_id: 5, range_in_cents: 190_000_01..INFINITY,   tax_rate: BigDecimal("0.45"), maximum_tax_amount: BigDecimal("Infinity")).freeze
      ].freeze

      def self.find_bracket(income_in_cents)
        NZ_TAX_BRACKETS.select { |bracket| bracket.include?(income_in_cents) }
      end

      def self.find_id(income_in_cents)
        NZ_TAX_BRACKETS.find { |bracket| bracket.range_in_cents.include?(income_in_cents) }.tax_bracket_id
      end
    end
  end
end
