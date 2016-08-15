module MinimalAdmin
  module Field
    class Base
      def initialize(dashboard, name, label: nil)
        @dashboard = dashboard
        @name = name
        @label = label
        @default_options = {
          dashboard: @dashboard,
          adapter: @dashboard.adapter,
          field: self,
          required: required?
        }
      end

      def render(app, record, options = {})
        record_options = { record: record, value: record.send(name) }
        options = @default_options.merge(record_options).merge(options)
        app.slim(:"application/field", locals: { field: self, options: options })
      end

      def parse_value(record, value)
        value
      end

      def label
        @label ||= @name.to_s.humanize
      end

      def resource_name
        self.class.to_s.demodulize.underscore
      end

      def stylesheets
        []
      end

      def javascripts
        []
      end

      def render_in_card_block?
        true
      end

      def show_required?
        true
      end

      def required?
        @dashboard.adapter.required?(@name)
      end

      attr_reader :name
    end
  end
end
