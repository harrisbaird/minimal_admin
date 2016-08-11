module MinimalAdmin
  module Action
    class Show < Action::Base
      def type
        :record
      end

      def template_type
        :show
      end

      def controller(app)
        render(app, record: find_record(app))
      end
    end
  end
end
