require 'active_support/core_ext/hash/compact'

module BlueprintAgreement
  class RequestBuilder

    def self.for(context)
      klass = case
              when rails?
                RailsRequest
              when rack_test?
                RackTestRequest
              end

      klass.new(context)
    end

    def self.rails?
      !!defined?(Rails)
    end

    def self.rack_test?
      !!defined?(Rack::Test)
    end

    class RackTestRequest

      def initialize(context)
        @context = context
      end

      def body
        @body ||= request.body.read
      end

      def content_type
        request.content_type
      end

      def request_method
        request.request_method
      end

      def fullpath
        request.fullpath
      end

      def headers
        @context.rack_test_session.instance_variable_get(:@headers)
      end

      def request
        @context.last_request
      end
    end

    class RailsRequest
      HEADER_PATCH = {
        "CONTENT_TYPE" => "Content-Type",
        "HTTP_AUTHORIZATION" => "Authorization",
        "rack.request.cookie_string" => "Cookie",
        "HTTP_COOKIE" => "Cookie",
      }

      def initialize(context)
        @context = context
      end

      def body
        @body ||= request.body.read
      end

      def content_type
        request.content_type
      end

      def request_method
        request.request_method
      end

      def fullpath
        request.fullpath
      end

      def headers
        HEADER_PATCH.each_with_object({}) do |header, result|
          header_name, key = header
          next unless @context.request.env.key?(header_name)
          result[key] = @context.request.env[header_name]
        end.compact
      end

      def request
        @context.request
      end
    end
  end
end
