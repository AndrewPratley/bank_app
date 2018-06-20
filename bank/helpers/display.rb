# frozen_string_literal: true

module Bank
  module Helpers
    module Display
      def print_slowly(text)
        text.each_char {|c| putc c ; sleep 0.02; $stdout.flush }
      end

      def display_accounts(accounts)
        accounts.each_with_index do |account, index|
          print_slowly "#{index + 1}.) Name: #{account.name}, Amount: #{account.formatted_balance}\n".light_blue
        end
      end

      def no_account_under_name_message
        print_slowly "Ain't no account under that name. Better make like a bald man\n\n".light_red
        print_slowly "...Gone...\n".light_red
      end
    end
  end
end
