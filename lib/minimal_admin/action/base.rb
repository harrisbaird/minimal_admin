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

      # :show, :form
      def template_type
        raise NotImplementedError
      end

      def http_methods
        [:get]
      end

      def controller(app)
      end

      def setup_routes(app)
        action = self
        http_methods.each do |http_method|
          path = MinimalAdmin::Routing.path_for_action(self, ':id')
          app.send(http_method, path) do
            @dashboard = action.dashboard
            @action = action
            action.load_records(self)
            action.controller(self)
            render_assets(action.fields.values)
            slim(action.template_path)
          end
        end
      end

      def resource_name
        self.class.to_s.demodulize.underscore
      end

      def label
        self.class.to_s.demodulize.humanize
      end

      def render(app, options = {})
        render_template(app, options)
      end

      def template_path
        "action/#{resource_name}".to_sym
      end

      def load_records(app)
        case type
        when :collection
          page = (app.params[:page] || 1).to_i
          eager_load_fields = fields.keys & @dashboard.model.associations
          dataset = @dashboard.adapter.paginate(page)
          records = dataset.eager(eager_load_fields).all
          app.instance_variable_set('@dataset', dataset)
          app.instance_variable_set('@records', records)
        when :record
          record = @dashboard.adapter.find(app.params[:id])
          app.instance_variable_set('@record', record)
        end
      end

      attr_reader :dashboard, :fields
    end
  end
end
