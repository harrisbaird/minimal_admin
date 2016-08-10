module MinimalAdmin
  module Action
    class Edit < MutateBase
      def type
        :record
      end

      def controller(app)
        record = @dashboard.adapter.find(app.params[:id])
        super(app, record)
      end
    end
  end
end
