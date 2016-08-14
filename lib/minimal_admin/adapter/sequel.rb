require 'sequel'

module MinimalAdmin
  module Adapter
    class Sequel
      SEARCH_TYPES = [:integer, :string].freeze
      MISSING_RECORD_EXCEPTION = ::Sequel::NoMatchingRow

      def initialize(model)
        @model = model
      end

      def all(eager = nil)
        eager ? @model.eager(eager).all : @model.all
      end

      def find(id)
        @model.with_pk!(id)
      end

      def new(*args)
        @model.new(*args)
      end

      def associations
        @model.associations
      end

      def association_class(name)
        @model.association_reflection(name)[:class_name]
      end

      def required_fields
        @model.new.tap(&:valid?).errors.map do |k, v|
          k if v.include?('is not present')
        end.compact
      end

      def paginate(page, limit = 100)
        dataset = @model.dataset
        dataset = dataset.extension(:pagination)
        dataset.paginate(page, limit)
      end

      def search(query)
        fields = search_fields.map { |name| ::Sequel.cast(name, :text) }
        @model.grep(fields, "#{query}%", case_insensitive: true).limit(100).all
      end

      private

      def search_fields
        @model.db_schema.map do |k, v|
          k if SEARCH_TYPES.include?(v[:type])
        end.compact
      end
    end
  end
end
