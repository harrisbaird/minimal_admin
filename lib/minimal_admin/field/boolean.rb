module MinimalAdmin
  module Field
    class Boolean < Field::Base
      def parse_value(record, name, value)
        value == '1'
      end

      def show_required?
        false
      end
    end
  end
end
