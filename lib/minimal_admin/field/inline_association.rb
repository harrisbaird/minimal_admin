module MinimalAdmin
  module Field
    class InlineAssociation < Field::Base
      def render(app, name, record, options = {})
        association_model = record.model.association_reflection(name)[:class_name].constantize
        options[:dashboard] = MinimalAdmin.find_dashboard(association_model)
        options[:action] = options[:dashboard].find_action(:index)
        options[:records] = Array.wrap(record.send(name))
        options[:hide_actions] = true

        render_template(app, name, record, options)
      end

      def template_path(action)
        :'application/inline_records'
      end

      def render_in_card_block?
        false
      end
    end
  end
end
