module MinimalAdmin
  module Action
    class Edit < Base
      def type
        :record
      end

      def template_type
        :form
      end

      def http_methods
        [:get, :put]
      end

      def controller(app)
        super
        record = app.instance_variable_get('@record')
        if app.request.put?
          app.params['form'].each do |k, v|
            field = fields.find { |f| f.name.to_sym == k.to_sym }
            v = field.parse_value(record, v)
            ["#{k}_id=", "#{k}="].each do |meth|
              record.send(meth, v) if record.respond_to?(meth)
            end
          end

          if record.save
            app.flash[:success] = "#{@dashboard.label} successfully updated."
            type = app.params['_add_another'] ? :new : :show
            app.redirect(path_for_record(record, type))
          else
            app.flash[:error] = "#{@dashboard.label} is invalid"
          end
        end
      end
    end
  end
end
