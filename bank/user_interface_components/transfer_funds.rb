# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class TransferFunds

      extend Bank::Helpers::Display

      def self.display_and_transfer_funds(from_account, amount, to_account)
        print_slowly 'transferring now...'.light_green
        print_slowly "what, you think this is minority report or somethin'? Just stick it in that box!\n".light_green

        until ::Bank::Amount.valid?(amount) do
          print_slowly "\nWhat you kiddin' me?\n\n" \
               "Yo mama so poor, she buys Big Macs on a payment plan\n\n".light_red
          print "Bra, I know you only got pennies, now spit it: ".light_red
          amount = gets.chomp
        end

        from_account.transfer_to(to_account, amount)

        print_slowly "\nOkay, it's stashed. Untraceable.\n".light_green
      end
    end
  end
end
