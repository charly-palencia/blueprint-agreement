require 'singleton'

module BlueprintAgreement
  module Utils
    class RequestLogger
      include Singleton

      def for(body:, content_type:, authorization:, path:, request_method:)
        @content_type = content_type
        @authorization = authorization
        @body = body
        @path = path
        @request_method = request_method
      end

      def print
        %{
          Method: #{@request_method}
          Path: #{@path}

          Details

          Content-Type: #{@content_type}
          Authorization: #{@authorization}

          Body:
          #{@body.read}
        }
      end
    end
  end
end
