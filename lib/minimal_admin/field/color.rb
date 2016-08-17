module MinimalAdmin
  module Field
    class Color < Field::Base
      def parse_value(record, value)
        if value.present?
          if value =~ /^[0-9a-fA-F]{3,6}$/
            '#' + value
          else
            value
          end
        end
      end
    end
  end
end
