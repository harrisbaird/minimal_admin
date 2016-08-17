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
    end
  end
end
