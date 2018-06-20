# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class SelectAccount

      extend Bank::Helpers::Display

      def self.display_and_return_account
        print_slowly "\nWhich is yours?\n\n" \
             "Don't you be lyin to me now.\n\n".light_green

        accounts = ::Bank::Account.all_accounts

        accounts.each do |account|
          print_slowly "Account Id: #{account.id}, Name: #{account.name}, Balance: #{account.formatted_balance}\n"
        end

        print "\n\n??? Gimmie the id already: ".light_green

        account_id = gets.chomp
        possible_account_ids = accounts.map(&:id).map(&:to_s)

        until possible_account_ids.include?(account_id) do
          print "\nYou hard-a-hearing or somethin'? I said THE ID!: ".light_red
          account_id = gets.chomp
        end

        print_slowly "\nHello....this is your account?!?\n\n" \
             "You married?\n\n".light_green

        ::Bank::Account.load_account(account_id)
      end
    end
  end
end
