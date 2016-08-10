module MinimalAdmin
  module Action
    class Delete < Action::Base
      def type
        :record
      end

      def controller(app)
        render(app, record: @dashboard.adapter.find(app.params[:id]))
      end
    end
  end
end
