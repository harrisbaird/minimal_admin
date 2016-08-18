module MinimalAdmin
  class BaseDashboard
    include MinimalAdmin

    def self.inherited(subclass)
      MinimalAdmin.dashboards << subclass.new
      super
    end

    def model
      self.class::MODEL
    end

    def adapter
      @model ||= MinimalAdmin::Adapter::Sequel.new(model)
    end

    def setup_routes(app)
      actions.each { |action| action.setup_routes(app) }
    end

    def label
      @label ||= resource_name.humanize
    end

    def resource_name
      @route_param ||= demodulized_name.underscore.pluralize
    end

    def find_action(action_name)
      actions.find { |action| action.resource_name.to_sym == action_name.to_sym } ||
        raise("Missing '#{action_name}' action for #{self.class.name}")
    end

    def actions_for(type)
      actions.select { |a| a.type.to_sym == type.to_sym }
    end

    def actions
      []
    end

    private

    def demodulized_name
      @demodulized_name ||= self.class.to_s[/(.+)Dashboard/, 1].demodulize
    end
  end
end
