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
        @context.headers
      end

      def request
        @context.request
      end
    end
  end
end
