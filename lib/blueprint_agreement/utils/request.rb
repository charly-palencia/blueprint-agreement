module BlueprintAgreement
  module Utils
    class Request
      def self.from(context)
        klass = defined?(::Rails) ? RailsRequest : RackTestRequest
        method = defined?(::Rails) ? :request : :last_request
        klass.new(context.send(method))
      end

      def initialize(request)
        @request = request
      end
    end

    class RackTestRequest < Request
      def body
        @request.body
      end

      def content_type
        @request.content_type
      end

      def request_method
        @request.request_method
      end

      def fullpath
        @request.fullpath
      end

      def has_content_type?
        !content_type.nil?
      end

      def authorization
        @request.env['Authorization']
      end
    end

    class RailsRequest < Request
      def body
        @request.body
      end

      def content_type
        @request.content_type
      end

      def request_method
        @request.request_method
      end

      def fullpath
        @request.fullpath
      end

      def has_content_type?
        @request.has_content_type?
      end

      def authorization
        @request.authorization
      end
    end
  end
end
