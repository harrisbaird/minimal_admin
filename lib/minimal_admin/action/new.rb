module MinimalAdmin
  module Action
    class New < Edit
      def type
        :collection
      end

      def controller(app)
        app.instance_variable_set('@record', @dashboard.adapter.new)
        super
      end
    end
  end
end
