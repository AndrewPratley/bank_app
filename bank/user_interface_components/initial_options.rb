# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class InitialOptions

      extend Bank::Helpers::Display

      def self.display_and_get_response
        print_slowly "\nWha u want?!?:\n\n" \
                     "1.) Stole some dough and have no idea what to do\n" \
                     "2.) Cash it in\n" \
                     "3.) Siphon it out\n" \
                     "4.) Launder it around\n" \
                     "5.) Show me ma monay!\n\n".light_green
        print "1,2,3,4 or 5, that's all u got: ".light_green

        choice = gets.chomp.to_i

        until [1,2,3,4,5].include?(choice) do
          print "\nYou ain't hearin me right. 1...2...3...4 or 5!: ".light_red
          choice = gets.chomp.to_i
        end
        choice
      end
    end
  end
end
