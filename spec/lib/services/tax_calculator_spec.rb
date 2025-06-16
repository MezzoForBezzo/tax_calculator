require "rails_helper"

module Services
  RSpec.describe TaxCalculator do
    describe "#call" do
      let(:in_cents) { false }

      shared_examples "correctly taxed incomes" do
        subject { described_class.new(income: formatted_income, in_cents: in_cents).call }

        context "for an income of $10,000.00" do
          let(:income) { 10_000 }

          it { is_expected.to eq "$1,050.00" }
        end

        context "for an income of $35,000.00" do
          let(:income) { 35_000 }

          it { is_expected.to eq "$5,033.00" }
        end

        context "for an income of $100,000.00" do
          let(:income) { 100_000 }

          it { is_expected.to eq "$22,877.50" }
        end

        context "for an income of $220,000.00" do
          let(:income) { 220_000 }

          it { is_expected.to eq "$64,877.50" }
        end

        context "for an amount 1 cent either side of a bracket" do
          context "for an income of $15,600.00" do
            let(:income) { 15_600 }

            it { is_expected.to eq "$1,638.00" }
          end

          context "for an income of $15,601.00" do
            # this also results in a half cent of 1,638.175
            let(:income) { 15_601 }

            it { is_expected.to eq "$1,638.18" }
          end
        end
      end

      context "formatted income" do
        let(:formatted_income) { income.to_d }

        it_behaves_like "correctly taxed incomes"

        # Note: The rest is a bit overkill as the different tests mostly test the Monetized parser

        context "as Monetized cents" do
          let(:formatted_income) { Monetize.parse(income).cents }
          let(:in_cents) { true }

          it_behaves_like "correctly taxed incomes"
        end

        context "as Monetized dollars" do
          let(:formatted_income) { Monetize.parse(income).dollars }

          it_behaves_like "correctly taxed incomes"
        end

        context "as a BigDecimal" do
          let(:formatted_income) { BigDecimal(income) }

          it_behaves_like "correctly taxed incomes"
        end

        context "as a String" do
          let(:formatted_income) { income.to_s }

          it_behaves_like "correctly taxed incomes"
        end

        context "as a Float" do
          let(:formatted_income) { income.to_f }

          it_behaves_like "correctly taxed incomes"
        end
      end
    end
  end
end
