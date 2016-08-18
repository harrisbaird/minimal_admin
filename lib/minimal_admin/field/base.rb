module MinimalAdmin
  module Field
    class Base
      # FIXME: Option handling needs to be simplified
      def initialize(dashboard, name, options = {})
        @dashboard = dashboard
        @name = name
        options.each { |k, v| instance_variable_set("@#{k}", v) }
        @default_options = {
          dashboard: @dashboard,
          adapter: @dashboard.adapter,
          field: self,
          required: required?
        }.merge(options)
      end

      def render(app, record, options = {})
        record_options = { record: record, value: record.send(name) }
        options = @default_options.merge(record_options).merge(options)
        app.slim(:"application/field", locals: { field: self, options: options })
      end

      def assets(app)
        @assets ||= app.slim(:"field/#{resource_name}/assets") rescue ''
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
