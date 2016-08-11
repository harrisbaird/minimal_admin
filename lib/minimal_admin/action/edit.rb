module MinimalAdmin
  module Action
    class Edit < MutateBase
      def type
        :record
      end

      def controller(app)
        super(app, find_record(app))
      end
    end
  end
end
