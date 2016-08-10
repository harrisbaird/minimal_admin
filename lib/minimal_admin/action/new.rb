module MinimalAdmin
  module Action
    class New < MutateBase
      def type
        :collection
      end

      def controller(app)
        record = @dashboard.adapter.new
        super(app, record)
      end
    end
  end
end
