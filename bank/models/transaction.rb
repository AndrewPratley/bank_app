# frozen_string_literal: true

module Bank
  class Transaction
    class << self
      attr_accessor :all_transactions
    end

    attr_reader :account, :amount

    @all_transactions = []

    def initialize(account)
      @account = account
      @amount = nil
      @timestamp = nil
    end

    def record_transaction(amount_object)
      @amount = amount_object
      @timestamp = Time.now
      self.class.all_transactions << self
    end

    def self.within_daily_limit?(name, amount_to_withdraw)
      binding.pry
      customer_transactions_within_day = all_transactions.select do |transaction|
        transaction.account.name == name && transaction.timestamp < 1.day.ago
      end
      amount_customer_transacted_within_day = customer_transactions_within_day.map(&:amount).map(&:amount).reduce(:+)
      amount_customer_transacted_within_day + amount_to_withdraw > 10
    end

    private

    attr_writer :account, :amount
  end
end
