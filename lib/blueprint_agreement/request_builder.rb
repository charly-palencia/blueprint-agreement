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
        request_headers = BlueprintAgreement.configuration.request_headers
        request_headers.each_with_object({}) do |header, result|
          if @context.request.env.key?(header)
            result[header] = @context.request.env[header]
            next
          end
          uppercased_header = header.upcase.tr("-", "_")
          if @context.request.env.key?(uppercased_header)
            result[header] = @context.request.env[uppercased_header]
            next
          end
          http_prefixed_header = "HTTP_#{uppercased_header}"
          if @context.request.env.key?(http_prefixed_header)
            result[header] = @context.request.env[http_prefixed_header]
          end
        end.compact
      end

      def request
        @context.request
      end
    end
  end
end
