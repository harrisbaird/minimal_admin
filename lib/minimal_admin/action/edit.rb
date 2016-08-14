module MinimalAdmin
  module Action
    class Edit < MutateBase
      def type
        :record
      end
    end
  end
end
