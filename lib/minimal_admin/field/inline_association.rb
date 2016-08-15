module MinimalAdmin
  module Field
    class InlineAssociation < Field::Base
      def render(app, record, options = {})
        association_model = record.model.association_reflection(name)[:class_name].constantize
        options[:dashboard] = MinimalAdmin.find_dashboard(association_model)
        options[:action] = options[:dashboard].find_action(:index)
        options[:records] = Array.wrap(record.send(name))
        options[:hide_actions] = true
        super(app, record, options)
      end

      def render_in_card_block?
        false
      end
    end
  end
end
