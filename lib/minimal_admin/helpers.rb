module MinimalAdmin
  module Helpers
    ASSET_TYPES = [:stylesheets, :javascripts].freeze

    def path_for(dashboard, action, record_id = nil)
      MinimalAdmin.path_for(dashboard, action, record_id)
    end

    def field_label(field, name)
      field.label || name.to_s.humanize
    end

    def main_title
      MinimalAdmin.configuration.title
    end

    def title_for(prefix, record)
      title = record.respond_to?(:name) ? "'#{record.name}'" : record.id
      "#{prefix} #{record.class.name} #{title}"
    end

    def global_assets
      ASSET_TYPES.each_with_object({}) do |type, hsh|
        hsh[type] = MinimalAdmin.configuration.send(type)
      end
    end

    def render_assets(fields = [])
      ASSET_TYPES.each do |type|
        content_for(type) do
          assets = fields.flat_map(&type).uniq
          global = global_assets[type]
          slim(type, locals: { urls: global + assets })
        end
      end
    end

    def record_label(record)
      return 'New #{record.class.name}' if record.nil?
      record_str = "#{record.class.name} \##{record.id}"

      if record.respond_to?(:name)
        "#{record.name} (#{record_str})"
      else
        record_str
      end
    end

    def render_action_header(dashboard, action, record_id = nil)
      type = record_id.present? ? :record : :collection
      slim :header_actions, locals: {
        dashboard: dashboard,
        action: action,
        type: type,
        record_id: record_id
      }
    end

    def form_field_name(name)
      "form[#{name}]"
    end

    def form_field_id(name)
      "field_#{name}"
    end
  end
end
