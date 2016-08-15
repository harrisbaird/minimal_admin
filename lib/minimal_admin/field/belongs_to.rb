module MinimalAdmin
  module Field
    class BelongsTo < Field::Base
      def render(app, record, options = {})
        options[:dashboard] = MinimalAdmin.find_dashboard(record.class)
        super(app, record, options)
      end

      def parse_value(record, value)
        User.with_pk(value)
      end

      def stylesheets
        [
          'https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css',
          'https://cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-theme/0.1.0-beta.8/select2-bootstrap.min.css'
        ]
      end

      def javascripts
        ['https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js']
      end
    end
  end
end
