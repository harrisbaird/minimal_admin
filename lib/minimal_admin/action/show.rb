module MinimalAdmin
  module Action
    class Show < Action::Base
      def type
        :record
      end

      def template_type
        :show
      end
    end
  end
end
