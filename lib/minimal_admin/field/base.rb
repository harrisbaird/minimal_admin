module MinimalAdmin
  module Field
    class Base
      def render(app, name, record, options = {})
        render_template(app, name, record, options)
      end

      def parse_value(record, name, value)
        value
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

      attr_reader :label, :hint

      private

      def render_template(app, name, record, options = {})
        dashboard = MinimalAdmin.find_dashboard(record.model)
        options = {
          name: name,
          record: record,
          value: record.send(name),
          dashboard: dashboard,
          adapter: dashboard.adapter,
          required: dashboard.adapter.required_fields,
          field: self
        }.merge(options)
        action = app.instance_variable_get('@action')
        app.slim(:"field/#{resource_name}/#{action.template_type}", locals: options)
      end
    end
  end
end
