module MinimalAdmin
  module Action
    class Index < Action::Base
      def type
        :collection
      end

      def template_type
        :show
      end

      def label
        'List'
      end
    end
  end
end
