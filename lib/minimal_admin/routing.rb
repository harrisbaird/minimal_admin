module MinimalAdmin
  module Routing
    def path_for_action(action, record_id = nil)
      dashboard = action.dashboard
      route = case action.type
              when :collection
                [dashboard.resource_name, action.resource_name]
              when :record
                [dashboard.resource_name, record_id, action.resource_name]
              end.compact
      '/' + route.join('/')
    end
    module_function :path_for_action

    def path_for_dashboard(dashboard, action)
      action = dashboard.find_action(action)
      path_for_action(action)
    end
    module_function :path_for_dashboard

    def path_for_model(model, action, record_id = nil)
      action = find_action(action, model)
      path_for_action(action, record_id)
    end
    module_function :path_for_model

    def path_for_record(record, action)
      action = find_action(action, record.model)
      path_for_model(record.model, action, record.id)
    end
    module_function :path_for_record

    private

    def find_action(action, model)
      if action.is_a?(Symbol)
        dashboard = MinimalAdmin.find_dashboard(model)
        action = dashboard.find_action(action)
      end
      action
    end
    module_function :find_action
  end
end
