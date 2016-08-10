module MinimalAdmin
  module Action
    class Base
      def initialize(dashboard, fields = {})
        @dashboard = dashboard
        @fields = fields
      end

      # :collection, :record, :root
      def type
        raise NotImplementedError
      end

      # :index, :show, :form
      def template_type
        raise NotImplementedError
      end

      def controller(app)
        raise NotImplementedError
      end

      def http_methods
        [:get]
      end

      def setup_routes(app)
        action = self
        http_methods.each do |http_method|
          path = MinimalAdmin.path_for(@dashboard, self, ':id')
          app.send(http_method, path) do
            action.controller(self)
          end
        end
      end

      def resource_name
        self.class.to_s.demodulize.underscore
      end

      def route
        resource_name
      end

      def label
        self.class.to_s.demodulize.humanize
      end

      def render(app, options = {})
        render_template(app, options)
      end

      attr_reader :dashboard, :fields

      private

      def render_template(app, options = {})
        options = {
          dashboard: @dashboard,
          action: self,
          adapter: @dashboard.adapter,
          required_fields: @dashboard.adapter.required_fields
        }.merge(options)
        app.render_assets(@fields.values)
        app.slim(template_path, locals: options)
      end

      def template_path
        "action/#{resource_name}".to_sym
      end
    end
  end
end
