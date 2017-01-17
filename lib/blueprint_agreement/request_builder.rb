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

      DEFAULT_HEADERS =  %w[
        HTTP_ACCEPT HTTP_ACCEPT_CHARSET HTTP_ACCEPT_ENCODING
        HTTP_ACCEPT_LANGUAGE HTTP_CACHE_CONTROL HTTP_FROM
        HTTP_NEGOTIATE HTTP_PRAGMA HTTP_CLIENT_IP
        HTTP_X_FORWARDED_FOR HTTP_ORIGIN HTTP_VERSION
        HTTP_X_CSRF_TOKEN HTTP_X_REQUEST_ID HTTP_X_FORWARDED_HOST
        SERVER_ADDR
        ].freeze

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
        headers = {}

        DEFAULT_HEADERS.each do |env|
          next unless @context.request.env.key?(env)
          key = env.sub(/^HTTP_/n, '').downcase
          headers[key] = @context.request.env[env]
        end

        HEADER_PATCH.each do |header|
          header_name, key = header
          next unless @context.request.env.key?(header_name)
          headers[key] = @context.request.env[header_name]
        end

        headers.compact
      end

      def request
        @context.request
      end
    end
  end
end
