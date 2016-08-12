module MinimalAdmin
  module Action
    class Index < Action::Base
      def type
        :collection
      end

      def template_type
        :index
      end

      def label
        'List'
      end

      def route
        nil
      end

      def controller(app)
        page = (app.params[:page] || 1).to_i
        dataset = @dashboard.model.dataset
        dataset = dataset.extension(:pagination)
        dataset = dataset.paginate(page, 100)

        render(app, records: dataset.eager(eager_load_fields).all,
                    dataset: dataset)
      end
    end
  end
end
