# frozen_string_literal: true

require_relative '../../../Gemfile'

module Bank
  describe Amount do
    describe '#new' do
      subject(:amount) { described_class.new(amount_in_smallest_denominator) }

      let(:amount_in_smallest_denominator) { 100 }

      context 'when the input is valid' do
        specify { expect { amount }.not_to raise_error }
      end

      context 'when the input is not valid' do
        context 'when the input is abc' do
          let(:amount_in_smallest_denominator) { 'abc' }

          specify { expect { amount }.to raise_error(Amount::AmountMustBeAnInteger) }
        end

        context 'when the input is -100' do
          let(:amount_in_smallest_denominator) { -100 }

          specify { expect { amount }.to raise_error(Amount::AmountMustBeAnInteger) }
        end

        context 'when the input is an object' do
          let(:amount_in_smallest_denominator) { Account.new(100) }

          specify { expect { amount }.to raise_error(Amount::AmountMustBeAnInteger) }
        end

        context 'when the input has a decimal place' do
          let(:amount_in_smallest_denominator) { 100.12 }

          specify { expect { amount }.to raise_error(Amount::AmountMustBeAnInteger) }
        end
      end
    end

    describe '.valid?' do
      subject(:valid?) { described_class.valid?(given_amount) }

      let(:given_amount) { '100' }

      context 'when the input is valid' do
        it { is_expected.to eq true }
      end

      context 'when it is not valid' do
        let(:given_amount) { 'abc' }

        it { is_expected.to eq false }
      end
    end
  end
end
