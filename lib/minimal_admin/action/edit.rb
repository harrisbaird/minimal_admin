module MinimalAdmin
  module Action
    class Edit < MutateBase
      def type
        :record
      end

      def controller(app)
        render(app, record: find_record(app))
      end
    end
  end
end
