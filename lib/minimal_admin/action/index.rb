module MinimalAdmin
  module Action
    class Index < Action::Base
      def type
        :collection
      end

      def template_type
        :index
      end

      def label
        'List'
      end

      def route
        nil
      end

      def controller(app)
        render(app, records: @dashboard.adapter.all)
      end
    end
  end
end
