module MinimalAdmin
  module Field
    class Boolean < Field::Base
      def parse_value(record, value)
        value == '1'
      end

      def show_required?
        false
      end
    end
  end
end
