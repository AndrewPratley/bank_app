# frozen_string_literal: true

require_relative '../../../Gemfile'

module Bank
  describe Account do
    subject(:account) { described_class.new(initial_deposit_in_cents) }

    let(:initial_deposit_in_cents) { 100 }

    describe '.new' do
      context 'with an initial amount of 100 cents' do
        specify { expect { account }.not_to raise_error }
      end

      context 'with an initial amount of 0 cents' do
        let(:initial_deposit_in_cents) { 0 }

        specify { expect { account }.not_to raise_error }
      end

      context 'with an initial amount of -100 cents' do
        let(:initial_deposit_in_cents) { -100 }

        specify { expect { account }.to raise_error(Amount::AmountMustBeAnInteger) }
      end

      context 'with an initial amount of abc cents' do
        let(:initial_deposit_in_cents) { 'abc' }

        specify { expect { account }.to raise_error(Amount::AmountMustBeAnInteger) }
      end

      context 'with an initial amount is false' do
        let(:initial_deposit_in_cents) { false }

        specify { expect { account }.to raise_error(Amount::AmountMustBeAnInteger) }
      end

      context 'with an initial amount is true' do
        let(:initial_deposit_in_cents) { true }

        specify { expect { account }.to raise_error(Amount::AmountMustBeAnInteger) }
      end

      context 'with an initial amount is an object' do
        let(:initial_deposit_in_cents) { String.new() }

        specify { expect { account }.to raise_error(Amount::AmountMustBeAnInteger) }
      end
    end

    describe '#formatted_balance' do
      subject(:formatted_balance) { account.formatted_balance }

      context 'when the initial amount is 100' do
        it { is_expected.to eq '$1.00' }
      end

      context 'when the initial amount is 5500' do
        let(:initial_deposit_in_cents) { 5555 }

        it { is_expected.to eq '$55.55' }
      end
    end

    describe '#deposit' do
      subject(:deposit) { account.deposit(amount_in_smallest_denominator) }

      let(:amount_in_smallest_denominator) { 100 }

      context 'when depositing 100 cents' do
        specify do
          expect { deposit }
            .to change { account.formatted_balance }
            .from('$1.00')
            .to('$2.00')
        end
      end

      context 'when depositing 5555 cents' do
        let(:amount_in_smallest_denominator) { 5555 }

        specify do
          expect { deposit }
            .to change { account.formatted_balance }
            .from('$1.00')
            .to('$56.55')
        end
      end

      context 'when depositing abc cents' do
        let(:amount_in_smallest_denominator) { 'abc' }

        specify do
          expect { deposit }.to raise_error(Amount::AmountMustBeAnInteger)
        end
      end
    end

    describe '#withdraw' do
      subject(:withdraw) { account.withdraw(withdrawal_amount) }

      let(:withdrawal_amount) { 50 }

      context 'when there is sufficient funds' do
        specify do
          expect { withdraw }
            .to change { account.formatted_balance }
            .from('$1.00')
            .to('$0.50')
        end
      end

      context 'when there is insufficient funds' do
        let(:withdrawal_amount) { 200 }

        specify do
          expect{ withdraw }.to raise_error(Account::InsufficientFundsError)
        end
      end

      context 'when abc is passed in' do
        let(:withdrawal_amount) { 'abc' }

        specify do
          expect{ withdraw }.to raise_error(Amount::AmountMustBeAnInteger)
        end
      end
    end

    describe '#transfer_to' do
      subject(:transfer_to) { account.transfer_to(account_2, transfer_amount) }

      let(:account_2) { described_class.new(100) }
      let(:transfer_amount) { 50 }

      context 'when inputs are valid' do
        specify do
          expect(account.formatted_balance).to eq '$1.00'
          expect(account_2.formatted_balance).to eq '$1.00'
          transfer_to
          expect(account.formatted_balance).to eq '$0.50'
          expect(account_2.formatted_balance).to eq '$1.50'
        end
      end

      context 'when invalid account is entered' do
        let(:account_2) { 'not_an_account' }

        specify do
          expect { transfer_to }.to raise_error(Account::NotAValidAccountError)
        end
      end

      context 'when there is insufficient funds in withdrawing account' do
        let(:transfer_amount) { 250 }

        specify do
          expect { transfer_to }.to raise_error(Account::InsufficientFundsError)
        end
      end
    end
  end
end
