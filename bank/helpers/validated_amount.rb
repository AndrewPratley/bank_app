# frozen_string_literal: true

module Bank
  module Helpers
    class ValidatedAmount

      def self.display_and_return_amount
        print "...how much we talking about here?: ".light_green

        amount = gets.chomp

        until ::Bank::Amount.valid?(amount) do
          print "\nKeep talking like that and you'll have another thing comin': ".light_red
          amount = gets.chomp
        end

        amount
      end
    end
  end
end
