module Cubic
  module CoreExtensions
    module Parse
      def integer?
        [
          /^[-+]?[1-9]([0-9]*)?$/,
          /^0[0-7]+$/,
          /^0x[0-9A-Fa-f]+$/,
          /^0b[01]+$/
        ].each do |match_pattern|
          return true if self =~ match_pattern
        end
        false
      end
    end
  end
end
