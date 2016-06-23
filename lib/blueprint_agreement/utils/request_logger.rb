require 'singleton'

module BlueprintAgreement
  module Utils
    class RequestLogger
      include Singleton

      def for(body:, headers:, path:, request_method:)
        @body = body
        @path = path
        @request_method = request_method
        @headers = headers
      end

      def print
        header_output =  @headers.to_a.map { |header| header.join("=") }.join("\n")
        %{
          Method: #{@request_method}
          Path: #{@path}

          Details

          Headers:

          #{ header_output }

          Body:
          #{@body}
        }
      end
    end
  end
end
