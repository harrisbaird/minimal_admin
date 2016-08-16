require 'minimal_admin/routing'

module MinimalAdmin
  module Action
    class Base
      include Routing

      def initialize(dashboard, fields = {}, order: :id, order_reverse: true)
        @dashboard = dashboard
        @fields = fields
        @order = order
        @order_reverse = order_reverse
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
          path = path_for_action(self, ':id')
          app.send(http_method, path) do
            @dashboard = action.dashboard
            @action = action
            action.load(self)
            action.controller(self)
            render_assets(action.fields)
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

      def order(dataset)
        @order_reverse ? dataset.reverse(@order) : dataset.order(@order)
      end

      def load(app)
        case type
        when :collection
          load_records(app)
        when :record
          load_record(app)
        end
      end

      attr_reader :dashboard, :fields

      private

      def load_record(app)
        record = @dashboard.adapter.find(app.params[:id])
        app.instance_variable_set('@record', record)
      end

      def load_records(app)
        page = (app.params[:page] || 1).to_i
        eager_load_fields = fields.map(&:name) & @dashboard.model.associations
        dataset = @dashboard.adapter.paginate(page)
        dataset = order(dataset)
        records = dataset.eager(eager_load_fields).all
        app.instance_variable_set('@dataset', dataset)
        app.instance_variable_set('@records', records)
      end
    end
  end
end
