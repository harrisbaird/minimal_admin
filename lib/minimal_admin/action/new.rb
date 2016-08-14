module MinimalAdmin
  module Action
    class New < MutateBase
      def type
        :collection
      end
    end
  end
end
