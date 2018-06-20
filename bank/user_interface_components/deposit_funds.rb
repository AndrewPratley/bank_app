# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class DepositFunds

      extend Bank::Helpers::Display

      def self.display_and_deposit_funds(account)
        print_slowly "...and how much might that be?...: ".light_green

        amount = gets.chomp

        until ::Bank::Amount.valid?(amount) do
          print_slowly "\nWhat you kiddin' me?\n\n" \
               "Yo mama so poor, she buys Big Macs on a payment plan\n\n".light_red
          print "Bra, I know you only got pennies, now spit it: ".light_red
          amount = gets.chomp
        end

        account.deposit(amount)

        print_slowly "\nNow were talkin'.\n\n" \
             "I'll siphon that away for you.\n".light_green
      end
    end
  end
end
