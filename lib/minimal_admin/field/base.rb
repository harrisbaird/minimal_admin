module MinimalAdmin
  module Field
    class Base
      def initialize(dashboard, name, label: nil)
        @dashboard = dashboard
        @name = name
        @label = label
      end

      def render(app, record, options = {})
        render_template(app, record, options)
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

      private

      def render_template(app, record, options = {})
        options = {
          record: record,
          value: record.send(name),
          dashboard: @dashboard,
          adapter: @dashboard.adapter,
          field: self,
          required: required?
        }.merge(options)
        action = app.instance_variable_get('@action')
        app.slim(:"field/#{resource_name}/#{action.template_type}", locals: options)
      end
    end
  end
end
