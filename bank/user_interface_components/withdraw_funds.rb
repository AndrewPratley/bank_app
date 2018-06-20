# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class WithdrawFunds

      extend Bank::Helpers::Display

      def self.display_and_withdraw_funds(account)
        print "...and how much might that be?...: ".light_green

        amount = gets.chomp

        until ::Bank::Amount.valid?(amount) && ::Bank::Account.can_withdraw?(account, amount) do
          print_slowly "\nWhat you kiddin' me?\n\n" \
               "Yo mama so poor, she buys Big Macs on a payment plan\n\n".light_red
          print "Bra, you only got pennies, so spit it: ".light_red
          amount = gets.chomp
        end

        account.withdraw(amount)

        print_slowly "\nHere you go. You can get a total of 2 lollipops with that.".light_green
      end
    end
  end
end
