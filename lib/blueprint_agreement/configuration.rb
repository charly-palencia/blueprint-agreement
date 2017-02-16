module BlueprintAgreement
  class Configuration
    attr_reader :allow_headers
    attr_accessor :active_service,
      :exclude_attributes,
      :port,
      :hostname,
      :server_path,
      :request_headers

    def initialize
      @active_service = nil
      @exclude_attributes = nil
      @allow_headers = nil
      @port = "8082"
      @hostname = "http://localhost"
      @server_path = "./docs"
      @request_headers = ["Content-Type", "Authorization", "Cookie"]
    end

    def active_service?
      !!@active_service
    end

    def allow_headers=(headers)
      @allow_headers = headers.map { |header| "--header #{header}" }.join(" ")
    end

    def default_format
      '*.apib'
    end
  end
end
