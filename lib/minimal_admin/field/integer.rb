module MinimalAdmin
  module Field
    class Integer < Field::Base
      def parse_value(record, name, value)
        Integer(value)
      end
    end
  end
end
