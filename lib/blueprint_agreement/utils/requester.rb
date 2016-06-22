require 'net/http'

module BlueprintAgreement
  module Utils
    class Requester
      REQUEST_OPTIONS = {
        "GET" => Net::HTTP::Get,
        "POST" =>  Net::HTTP::Post,
        "PUT" =>  Net::HTTP::Put,
        "DELETE" => Net::HTTP::Delete
      }

      def initialize(request, server)
        @current_request = request
        @server = server
      end

      def perform
        begin
          Net::HTTP.start(request_path.host, request_path.port) do |http|
            request = REQUEST_OPTIONS[request_method].new request_path
            set_form_data(request)
            set_headers(request)

            request_logger.for({
              body: current_request.body,
              content_type: current_request.content_type,
              authorization: current_request.authorization,
              path: request_path,
              request_method: request_method
            })

            http.request(request).tap do |http_request|
              puts request_logger.print if ENV["AGREEMENT_LOUD"]
              raise EndpointNotFound.new(http_request) if http_request.code == "404"
            end
          end
        rescue Errno::ECONNREFUSED
          sleep 1
          perform
        end
      end

      private

      def request_logger
        Utils::RequestLogger.instance
      end

      def set_headers(request)
        request['Content-Type'] = current_request.content_type if current_request.has_content_type?
        request['Authorization'] = current_request.authorization unless current_request.authorization.nil?
      end

      def set_form_data(request)
        if ['POST', 'PUT'].include? request_method
          request.body = current_request.body.read
        end
      end

      def request_method
        @request_method ||= current_request.request_method
      end

      def request_path
        @request_path ||= URI.join(server.host, current_request.fullpath)
      end

      attr_reader :current_request, :server
    end
  end
end
