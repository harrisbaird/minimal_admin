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

      def stylesheets
        ['https://cdn.jsdelivr.net/jquery.minicolors/2.1.2/jquery.minicolors.css']
      end

      def javascripts
        ['https://cdn.jsdelivr.net/jquery.minicolors/2.1.2/jquery.minicolors.min.js']
      end
    end
  end
end
