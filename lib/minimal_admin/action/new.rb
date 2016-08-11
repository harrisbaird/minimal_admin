module MinimalAdmin
  module Action
    class New < MutateBase
      def type
        :collection
      end

      def controller(app)
        super(app, record: @dashboard.adapter.new)
      end
    end
  end
end
