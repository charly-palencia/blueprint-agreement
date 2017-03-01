require 'net/http'

module BlueprintAgreement
  class Requester
    attr_reader :current_request,
      :request_method,
      :request_path

    REQUEST_OPTIONS = {
      'GET' => Net::HTTP::Get,
      'POST' => Net::HTTP::Post,
      'PUT' => Net::HTTP::Put,
      'DELETE' => Net::HTTP::Delete,
      'PATCH' => Net::HTTP::Patch,
      'TRACE' => Net::HTTP::Trace,
      'OPTIONS' => Net::HTTP::Options
    }.freeze

    def initialize(request)
      @config = BlueprintAgreement.configuration
      @current_request = request
      @request_method = @current_request.request_method
      fullhost = "#{@config.hostname}:#{@config.port}"
      @request_path = URI.join(fullhost, @current_request.fullpath)
      @request_option = REQUEST_OPTIONS[@request_method]
      raise BlueprintAgreement::HttpMethodNotFoundError if @request_option.nil?
    end

    def perform
      Net::HTTP.start(@request_path.host, @request_path.port) do |http|
        http_request = @request_option.new(@request_path)
        set_form_data(http_request)
        set_headers(http_request)

        request_logger.for({
          body: current_request.body,
          headers: current_request.headers,
          path: @request_path,
          request_method: request_method
        })

        http.request(http_request).tap do |http_request|
          puts request_logger.print if ENV["AGREEMENT_LOUD"]
          raise EndpointNotFoundError.new(http_request) if http_request.code == "404"
        end
      end
    rescue Errno::ECONNREFUSED
      sleep 1
      perform
    rescue Errno::ECONNRESET
      sleep 1
      perform
    end

    private

    def request_logger
      Utils::RequestLogger.instance
    end

    def set_headers(http_request)
      current_request.headers.each do |key, value|
        http_request[key] = value
      end
    end

    def set_form_data(http_request)
      if ['POST', 'PUT', 'PATCH'].include? request_method
        http_request.body = current_request.body
      end
    end
  end
end
