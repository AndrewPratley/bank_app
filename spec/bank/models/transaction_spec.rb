# frozen_string_literal: true

require_relative '../../../Gemfile'

module Bank
  describe Transaction do
    subject(:transaction) { described_class.new(account) }

    let(:account) { instance_double(Bank::Account) }

    describe '#new' do
      specify do
        expect(transaction.account).to eq account
        expect(transaction.amount).to eq nil
      end
    end

    describe '#record_transaction' do
      subject(:record_transaction) { transaction.record_transaction(amount) }

      let(:amount) { instance_double(Bank::Amount) }

      specify do
        record_transaction
        expect(transaction.amount).to eq amount
        expect(described_class.all_transactions).to include(transaction)
      end
    end

    describe '#within_daily_limit?' do
      subject(:within_daily_limit?) { described_class.within_daily_limit?(name, amount_to_withdraw) }

      let(:name) { 'Ding Dong' }
      let(:amount_to_withdraw) { Amount.new(100) }

      specify do
        Transaction.all_transactions = []
        expect(within_daily_limit?).to eq true
      end
    end
  end
end
