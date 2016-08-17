module MinimalAdmin
  module Helpers
    ASSET_TYPES = [:stylesheets, :javascripts].freeze

    # Allow templates to be loaded from multiple locations
    def find_template(views, name, engine, &block)
      views.each { |v| super(v, name, engine, &block) }
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
      if record.nil?
        'New #{record.class.name}'
      elsif record.respond_to?(:name)
        record.name
      else
        "#{record.class.name} \##{record.id}"
      end
    end

    def table_field_class(field)
      field_name = field.name.to_s.dasherize
      resource_name = field.resource_name.to_s.dasherize
      "#{field_name}-field #{resource_name}-type"
    end

    def form_field_name(field)
      "form[#{field.name}]"
    end

    def form_field_id(field)
      "field_#{field.name}"
    end

    def pagination_path(page)
      uri = URI.parse(request.path)
      uri.query = params.symbolize_keys.merge(page: page).to_query
      uri.to_s
    end

    def pagination_info(dataset)
      start = dataset.current_page_record_range.first
      finish = dataset.current_page_record_range.last
      total = dataset.pagination_record_count
      "Showing #{start} to #{finish} of #{total}"
    end
  end
end
