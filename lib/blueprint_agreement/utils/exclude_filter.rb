require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/object/blank'


module BlueprintAgreement
  class ExcludeFilter
    class << self
      def deep_exclude(content, exclude_attributes)
        return content if content.blank? || !content.is_a?(Hash)
        new(exclude_attributes).deep_exclude(content)
      end
    end

    def initialize(exclude_attributes)
      @exclude_attributes = exclude_attributes
    end

    def deep_exclude(content)
      return content if @exclude_attributes.nil?

      content.with_indifferent_access.tap do |params|
        @exclude_attributes.flatten.each do |filter|
          case filter
          when Symbol, String
            params.delete(filter) && params if params.has_key?(filter)
          when Hash then
            hash_filter(params, filter)
          end
        end
      end
    end

    private

    def hash_filter(params, filter)
      filter = filter.with_indifferent_access

      params.slice(*filter.keys).each do |key, value|
        next unless value
        next unless params.has_key? key

        if value.is_a?(Array) || value.is_a?(Hash)
          params[key] = each_element(value) do |element|
            self.class.deep_exclude(element, Array.wrap(filter[key]))
          end
        end
      end
    end

    def each_element(object)
      case object
      when Array
        object.grep(Hash).map { |el| yield el }.compact
      when Hash
        if fields_for_style? object
          hash = object.class.new
          object.each { |k,v| hash[k] = yield v }
          hash
        else
          yield object
        end
      end
    end

    def fields_for_style?(object)
      object.is_a?(Hash) && object.all? { |k, v| k =~ /\A-?\d+\z/ && v.is_a?(Hash) }
    end
  end
end
