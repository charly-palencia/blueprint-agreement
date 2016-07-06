module BlueprintAgreement
  module Utils
    class Request
      def self.from(context)
        klass = defined?(::Rails) ? RailsRequest : RackTestRequest
        klass.new(context)
      end

      def initialize(context)
        @context = context
      end
    end

    class RackTestRequest < Request

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

    class RailsRequest < Request
      HEADER_PATCH = {"CONTENT_TYPE" => "Content-Type", "HTTP_AUTHORIZATION" => "Authorization"}

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
        HEADER_PATCH.each_with_object({}) do  |header, result|
          header_name, key = header
          result[key] = @context.request.headers[header_name]
        end.compact
      end

      def request
        @context.request
      end
    end
  end
end
