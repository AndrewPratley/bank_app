# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class DisplayCustomerAccounts

      extend Bank::Helpers::Display

      def self.request_name_and_display_accounts
        print "\nGimmie your name, first and last: ".light_green

        customer_full_name = gets.chomp

        print_slowly "\nOK\n\n".light_green

        customer_accounts = ::Bank::Account.select_customer_accounts(customer_full_name)

        if customer_accounts.length > 0
          display_accounts(customer_accounts)
          print_slowly "\nAsk for a print out and you'll go negative.\n".light_green
        else
          no_account_under_name_message
        end

      end
    end
  end
end
