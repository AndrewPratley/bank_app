# frozen_string_literal: true

module Bank
  module UserInterfaceComponents
    class Logo

      def self.display
        banner = File.read('./assets/logo.txt')
        banner.yellow.each_char {|c| putc c ; sleep 0.001; $stdout.flush }
        "\n                  Welcome to the Future of Banking\n".light_green.each_char {|c| putc c ; sleep 0.01; $stdout.flush }
      end
    end
  end
end
