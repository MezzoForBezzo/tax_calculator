# frozen_string_literal: true

module Util
  class TaxBrackets
    TaxBracket = Struct.new(:tax_bracket, :range_in_cents, :tax_rate)

    NZ_TAX_BRACKETS = [
      TaxBracket.new(tax_bracket: 1, range_in_cents:          0..15_600_00,  tax_rate: 0.105).freeze,
      TaxBracket.new(tax_bracket: 2, range_in_cents:  15_600_01..53_500_00,  tax_rate: 0.175).freeze,
      TaxBracket.new(tax_bracket: 3, range_in_cents:  53_500_01..78_100_00,  tax_rate: 0.30).freeze,
      TaxBracket.new(tax_bracket: 4, range_in_cents:  78_100_01..180_000_00, tax_rate: 0.33).freeze,
      TaxBracket.new(tax_bracket: 5, range_in_cents: 180_000_01..,           tax_rate: 0.39).freeze
    ].freeze
  end
end
