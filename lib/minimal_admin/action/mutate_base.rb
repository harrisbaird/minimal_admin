module MinimalAdmin
  module Action
    class MutateBase < Action::Base
      def template_type
        :form
      end

      def http_methods
        [:get, :put]
      end

      def controller(app, record)
        if app.request.put?
          app.params['form'].each do |k, v|
            v = fields[k.to_sym].parse_value(record, k, v)
            ["#{k}_id=", "#{k}="].each do |meth|
              record.send(meth, v) if record.respond_to?(meth)
            end
          end

          if record.valid?
            record.save
            app.flash[:success] = "ok"
            # redirect action_path(@dashboard.table, :new) if params['_add_another']
          else
            app.flash[:error] = "Invalid data"
          end
        end

        render(app, record: record)
      end
    end
  end
end
