module MinimalAdmin
  module Field
    class Integer < Field::Base
      def parse_value(record, value)
        Integer(value)
      rescue ArgumentError
        0
      end
    end
  end
end
