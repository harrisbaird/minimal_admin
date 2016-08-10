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
        options = {
          name: name,
          record: record,
          value: record.send(name),
          field: self,
          required: options[:required_fields].include?(name)
        }.merge(options)
        app.slim(template_path(options[:action]), locals: options)
      end

      def template_path(action)
        "field/#{resource_name}/#{action.template_type}".to_sym
      end
    end
  end
end
