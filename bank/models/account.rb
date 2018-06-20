# frozen_string_literal: true

module Bank
  class Account
    class NotAValidAccountError < StandardError; end
    class InsufficientFundsError < StandardError; end

    attr_accessor :balance, :id, :name

    class << self
      attr_accessor :all_accounts
    end

    @all_accounts = []

    def initialize(name, initial_deposit_in_cents)
      @balance = Amount.new(initial_deposit_in_cents).amount
      @name = name
      @id = get_new_account_id
      self.class.all_accounts << self
    end

    def self.load_account(account_id)
      ::Bank::Account.all_accounts.select { |account| account.id == account_id.to_i }.first
    end

    def self.select_customer_accounts(customer_full_name)
      all_accounts.select { |account| account.name == customer_full_name }
    end

    def self.can_withdraw?(account, amount_to_withdraw)
      withdrawal_amount = Amount.new(amount_to_withdraw).amount
      (account.balance >= withdrawal_amount) #&& Transaction.within_daily_limit?(name, amount_to_withdraw)
    end

    def formatted_balance
      balance.format
    end

    def deposit(amount_in_smallest_denominator)
      self.balance += Amount.new(amount_in_smallest_denominator).amount
    end

    def withdraw(amount_in_smallest_denominator)
      amount_to_withdraw = Amount.new(amount_in_smallest_denominator).amount
      raise InsufficientFundsError if self.balance < amount_to_withdraw
      self.balance -= amount_to_withdraw
      Transaction.new(self).record_transaction(amount_to_withdraw)
    end

    def transfer_to(account, amount_in_smallest_denominator)
      raise NotAValidAccountError unless account.is_a?(Bank::Account)
      # Ideally, these would be in a transaction
      withdraw(amount_in_smallest_denominator)
      account.deposit(amount_in_smallest_denominator)
    end

    private

    def get_new_account_id
      return self.class.all_accounts.max_by(&:id).id + 1 if self.class.all_accounts.length > 0
      1
    end
  end
end
