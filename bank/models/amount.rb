# frozen_string_literal: true

module Bank
  class Amount
    class AmountCannotBeNegativeError < StandardError; end
    class AmountMustBeAnInteger < StandardError; end

    attr_reader :amount, :amount_in_smallest_denominator

    CURRENCY = 'USD'

    def initialize(amount_in_smallest_denominator)
      @amount_in_smallest_denominator = amount_in_smallest_denominator.to_s
      validate_amount
      @amount = Money.new(amount_in_smallest_denominator, CURRENCY)
    end

    def self.valid?(amount_in_smallest_denominator)
      amount = amount_in_smallest_denominator.to_s
      !amount.strip.empty? && !amount.match(/^\d*$/).nil?
    end

    private

    def validate_amount
      raise AmountMustBeAnInteger if amount_in_smallest_denominator.to_s.strip.empty? || amount_in_smallest_denominator.match(/^\d*$/).nil?
    end
  end
end
