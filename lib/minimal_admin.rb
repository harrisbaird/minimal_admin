require 'pathname'
require 'active_support/all'

require 'minimal_admin/version'
require 'minimal_admin/configuration'

module MinimalAdmin
  def self.dashboards
    @dashboards ||= []
  end

  def self.find_dashboard(model)
    dashboards.find { |dashboard| dashboard.model == model } ||
      raise("Missing dashboard for #{model}")
  end

  def self.path_for(dashboard, action, record_id = nil)
    action = dashboard.find_action(action) if action.is_a?(Symbol)
    route = case action.type
            when :root
              [action.route]
            when :collection
              [dashboard.resource_name, action.route]
            when :record
              [dashboard.resource_name, record_id, action.route]
            end.compact
    '/' + route.join('/')
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end

require 'minimal_admin/base_dashboard'

require 'minimal_admin/adapter/sequel'

require 'minimal_admin/action/base'
require 'minimal_admin/action/mutate_base'
require 'minimal_admin/action/delete'
require 'minimal_admin/action/edit'
require 'minimal_admin/action/index'
require 'minimal_admin/action/new'
require 'minimal_admin/action/show'

require 'minimal_admin/field/base'
require 'minimal_admin/field/belongs_to'
require 'minimal_admin/field/boolean'
require 'minimal_admin/field/color'
require 'minimal_admin/field/inline_association'
require 'minimal_admin/field/integer'
require 'minimal_admin/field/primary_key'
require 'minimal_admin/field/string'
