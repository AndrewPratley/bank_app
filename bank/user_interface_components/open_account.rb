# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class OpenAccount

      extend Bank::Helpers::Display

      def self.display_and_create_account
        print_slowly "\nWhere you steal this from boy?!?\n\n" \
             "Nvm, let me take care of that for you\n\n".light_green
        print "Gimmie your name, first and last: ".light_green

        name = gets.chomp

        print_slowly "\nOK\n\n".light_green

        amount = ::Bank::Helpers::ValidatedAmount.display_and_return_amount

        ::Bank::Account.new(name, amount)

        print_slowly "\nDang, that all you got?!?'.\n\n" \
             'Yo Mama is so poor, I saw her kicking a can down the street, and when I asked ' \
             "her what she was doing, she said, 'Moving'\n".light_green
      end
    end
  end
end
