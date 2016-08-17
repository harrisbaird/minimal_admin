module MinimalAdmin
  module Helpers
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

    def render_assets(fields = [])
      content_for(:assets) do
        fields.map do |field|
          field.assets(self)
        end.join
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
