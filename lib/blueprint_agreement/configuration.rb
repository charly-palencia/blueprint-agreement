module BlueprintAgreement
  class Configuration
    attr_accessor :active_service,
      :exclude_attributes,
      :allow_headers,
      :port,
      :hostname,
      :server_path

    def initialize
      @active_service = nil
      @exclude_attributes = nil
      @allow_headers = nil
      @port = "8082"
      @hostname = "http://localhost"
      @server_path = './docs'
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
