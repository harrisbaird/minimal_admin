module MinimalAdmin
  module Action
    class New < MutateBase
      def type
        :collection
      end

      def controller(app)
        super(app, find_record(app))
      end
    end
  end
end
